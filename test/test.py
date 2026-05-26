# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):

    dut._log.info("Start Comparator Test")

    # Create clock
    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0

    await ClockCycles(dut.clk, 5)

    dut.rst_n.value = 1

    # =========================================
    # Test 1 : Equal Condition
    # =========================================
    dut._log.info("Test 1 : Equal")

    dut.ui_in.value = 10
    dut.uio_in.value = 10

    await ClockCycles(dut.clk, 1)

    assert dut.uo_out.value == 1, \
        f"FAILED: Expected 1, Got {dut.uo_out.value}"

    # =========================================
    # Test 2 : Greater Than
    # =========================================
    dut._log.info("Test 2 : Greater Than")

    dut.ui_in.value = 25
    dut.uio_in.value = 10

    await ClockCycles(dut.clk, 1)

    assert dut.uo_out.value == 2, \
        f"FAILED: Expected 2, Got {dut.uo_out.value}"

    # =========================================
    # Test 3 : Less Than
    # =========================================
    dut._log.info("Test 3 : Less Than")

    dut.ui_in.value = 5
    dut.uio_in.value = 20

    await ClockCycles(dut.clk, 1)

    assert dut.uo_out.value == 4, \
        f"FAILED: Expected 4, Got {dut.uo_out.value}"

    # =========================================
    # Test 4 : Equal
    # =========================================
    dut._log.info("Test 4 : Equal")

    dut.ui_in.value = 100
    dut.uio_in.value = 100

    await ClockCycles(dut.clk, 1)

    assert dut.uo_out.value == 1, \
        f"FAILED: Expected 1, Got {dut.uo_out.value}"

    dut._log.info("All tests passed!")
