Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B02437CA1
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Oct 2021 20:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbhJVSie (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Oct 2021 14:38:34 -0400
Received: from foss.arm.com ([217.140.110.172]:57708 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233713AbhJVSie (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Oct 2021 14:38:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E48F1063;
        Fri, 22 Oct 2021 11:36:16 -0700 (PDT)
Received: from bogus (unknown [10.57.25.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0ADBA3F73D;
        Fri, 22 Oct 2021 11:36:14 -0700 (PDT)
Date:   Fri, 22 Oct 2021 19:36:12 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     ACPICA <devel@acpica.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [BUG REPORT][ACPICA] PCC Opregion: Wrong interpretation of channel
 index as table subtype
Message-ID: <20211022183612.jxhou2pzge6xkv2u@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

I am trying to add PCC Opregion support in the kernel and am hitting a
kernel crash when I add PCC Opregion in the ACPI ASL. Below is the
snippet of the crash:
-->8

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
 Workqueue: pm pm_runtime_work
 pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : __memcpy+0x54/0x260
 lr : acpi_ex_write_data_to_field+0xb8/0x194
 Call trace:
  __memcpy+0x54/0x260
  acpi_ex_store_object_to_node+0xa4/0x1d4
  acpi_ex_store+0x44/0x164
  acpi_ex_opcode_1A_1T_1R+0x25c/0x508
  acpi_ds_exec_end_op+0x1b4/0x44c
  acpi_ps_parse_loop+0x3a8/0x614
  acpi_ps_parse_aml+0x90/0x2f4
  acpi_ps_execute_method+0x11c/0x19c
  acpi_ns_evaluate+0x1ec/0x2b0
  acpi_evaluate_object+0x170/0x2b0
  acpi_device_set_power+0x118/0x310
  acpi_dev_suspend+0xd4/0x180
  acpi_subsys_runtime_suspend+0x28/0x38
  __rpm_callback+0x74/0x328
  rpm_suspend+0x2d8/0x624
  pm_runtime_work+0xa4/0xb8
  process_one_work+0x194/0x25c
  worker_thread+0x260/0x49c
  kthread+0x14c/0x30c
  ret_from_fork+0x10/0x20
 Code: f9000006 f81f80a7 d65f03c0 361000c2 (b9400026)
 ---[ end trace 24d8a032fa77b68a ]---

On debugging, I figured out that PCC channel index passed via region.address
in acpi_ex_store_object_to_node is interpreted as the channel subtype.

To confirm, I just hacked assuming we don't need to support type 1/2 PCC
with the change as below:

-->8

diff --git i/drivers/acpi/acpica/exfield.c w/drivers/acpi/acpica/exfield.c
index 06f3c9df1e22..8618500f23b3 100644
--- i/drivers/acpi/acpica/exfield.c
+++ w/drivers/acpi/acpica/exfield.c
@@ -330,12 +330,7 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
                       obj_desc->field.base_byte_offset,
                       source_desc->buffer.pointer, data_length);

-               if ((obj_desc->field.region_obj->region.address ==
-                    PCC_MASTER_SUBSPACE
-                    && MASTER_SUBSPACE_COMMAND(obj_desc->field.
-                                               base_byte_offset))
-                   || GENERIC_SUBSPACE_COMMAND(obj_desc->field.
-                                               base_byte_offset)) {
+               if (MASTER_SUBSPACE_COMMAND(obj_desc->field.base_byte_offset)) {

                        /* Perform the write */


With the above change, the crash disappears and correctly complains about
missing PCC Opregion handler(I have more questions on setting up one, will
follow that up separately).

-->8

ACPI Error: No handler for Region [PFRM] ((____ptrval____)) [PCC] (20210730/evregion-130)
ACPI Error: Region PCC (ID=10) has no handler (20210730/exfldio-261)
ACPI Error: Aborting method \_SB.ETH0._PS3 due to previous error (AE_NOT_EXIST) (20210730/psparse-531)

Not sure if my interpretation of the spec is incorrect or indeed this is
a bug. IIUC only _REG has both PCC channel index/address + the subtable type
embedded in the argument. The actual declaration of PCC Opregion just needs
the channel index as the address.

--
Regards,
Sudeep
