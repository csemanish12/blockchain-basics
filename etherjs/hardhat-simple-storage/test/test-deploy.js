const { describe } = require("node:test")
const { ethers } = require("hardhat")
const { assert, expect } = require("chai")

describe("SimpleStorage", function () {
    let simpleStorageFactory
    let simpleStorage

    // before each one of our test, this method is invoked
    beforeEach(async function () {
        simpleStorageFactory = await ethers.getContractFactory("SimpleStorage")
        simpleStorage = await simpleStorageFactory.deploy()
    })

    // actual test
    it("should start with a favorite number of 0", async function () {
        const currentValue = await simpleStorage.retrieve()
        const expectedValue = "0"

        assert.equal(currentValue.toString(), expectedValue)
    })

    it("should update when we call store", async function () {
        const expectedValue = "7"
        const transactionResponse = await simpleStorage.store(expectedValue)
        await transactionResponse.wait(1)

        const currentValue = await simpleStorage.retrieve()

        assert.equal(currentValue.toString(), expectedValue)
    })
})
