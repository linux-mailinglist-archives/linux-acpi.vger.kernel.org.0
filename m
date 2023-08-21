Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3513783197
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Aug 2023 21:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjHUTvg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 21 Aug 2023 15:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjHUTvg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Aug 2023 15:51:36 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D72111D
        for <linux-acpi@vger.kernel.org>; Mon, 21 Aug 2023 12:51:33 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 263aaab2bd53e7c7; Mon, 21 Aug 2023 21:51:31 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id AE3CF662C8C;
        Mon, 21 Aug 2023 21:51:30 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     acpica-devel@lists.linuxfoundation.org,
        "Kirill A . Shutemov" <kirill.shtuemov@linux.intel.com>
Subject: [RFC] ACPI Code First ECR: Support for resetting the Multiprocessor Wakeup Mailbox
Date:   Mon, 21 Aug 2023 21:51:30 +0200
Message-ID: <13356251.uLZWGnKmhe@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrudduledgudegfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthhqredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeetueduleelheeutdeigeetvefhuddvhffhveeigefhkeegudfgkefhuddutdetffenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprggtphhitggrqdguvghvvghlsehlihhsthhsrdhlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepkhhirhhilhhlrdhshhhtuhgvmhhovheslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The Multiprocessor Wakeup Structure in MADT is used for starting application
processors (APs) on systems without a hardware mechanism suitable for this
purpose.  It describes a mailbox (Multiprocessor Wakeup Mailbox) allowing
the boot CPU to send commands to APs and, in particular, to cause them to
jump to a wakeup vector provided by the OS.

As currently defined, after using the Multiprocessor Wakeup Mailbox to make
a given AP jump to the wakeup vector, it cannot be used any more with that AP,
which is problematic in some use cases, like kexec() or hibernation, because
it makes transferring control of APs from one OS instance to another difficult.

For this reason, the definition of Multiprocessor Wakeup Structure is changed
so as to allow the Multiprocessor Wakeup Mailbox to be reset in order to be
used once again with a given AP.

# Title: Add support for resetting the Multiprocessor Wakeup Mailbox

# Status: Draft

# Document: ACPI Specification 6.6

# License
SPDX-License Identifier: CC-BY-4.0

# Submitter:
* Sponsor: Rafael J. Wysocki, Intel
* Creator/Contributor: Kirill Shutemov, Intel

# Summary of the Change
Add a ResetVector field to Multiprocessor Wakeup Structure in order to provide
the OS with a physical address of a Multiprocessor Wakeup Mailbox entry point
for application processors that need to use the mailbox again after having used
it once already.

# Benefits of the Change
It will allow a new OS instance to be started without going through a full
system reset, for example after carrying out an OS update.

There are valid use cases in which the new OS started this way is different from
the OS that has been running so far and in the absence of a hardware mechanism
for resetting application processors, the only way to pass control of them from
one OS instance to the other is through the platform firmware.

# Impact of the Change
OS and platform firmware will need to recognize version 1 of the Multiprocessor
Wakeup Mailbox.

# Detailed Description of the Change
ACPI specification source changes needed to implement this proposal are as
follows:

---
 source/05_ACPI_Software_Programming_Model.rst |   40 +++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 4 deletions(-)

Index: ACPI_spec/source/05_ACPI_Software_Programming_Model.rst
===================================================================
--- ACPI_spec.orig/source/05_ACPI_Software_Programming_Model.rst
+++ ACPI_spec/source/05_ACPI_Software_Programming_Model.rst
@@ -4488,7 +4488,27 @@ The OS section can only be written by OS
 
 The OS section contains command, flags, APIC ID, and a wakeup address. After the OS detects the processor number from the MADT table, the OS may prepare the wakeup routine, fill the wakeup address field in the mailbox, indicate which processor need to be wakeup in the APID ID field, and send wakeup command. Once an application processor detects the wakeup command and its own APIC ID, the application processor will jump to the OS-provided wakeup address. The application processor will ignore the command if the APIC ID does not match its own.
 
-For each application processor, the mailbox can be used only once for the wakeup command. After the application process takes the action according to the command, this mailbox will no longer be checked by this application processor. Other processors can continue using the mailbox for the next command.
+For each application processor, the mailbox can be used only once for the wakeup command, unless
+the MailBoxVersion field value is greater than 0 and the ResetVector field contains a nonzero value.
+
+After the application process takes the action according to the command, this mailbox will no longer
+be checked by this application processor until the mailbox is reset for it as described below. Other
+processors can continue using the mailbox for the next command.
+
+In case the mailbox needs to be used once again, for example in order to start a new version of
+the OS without carrying out a full system reset, the ResetVector field value can be used for
+making the given application processor enter a state to check the mailbox. For this purpose,
+the OS needs to set up the mailbox reset environment, as per the ResetVector field description,
+for the application processor in question and make that application processor jump to the
+firmware-provided mailbox reset address retrieved from the ResetVector field. This needs to be
+done for each application processor individually and doing it for one application processor does
+not affect the other application processors, so they can continue to operate undisturbed.  However,
+if the ResetVector field value is 0, the mailbox cannot be reset and so it can be used only once.
+
+After an application processor has jumped to the reset address, the OS is required to verify that
+the mailbox responds to commands by sending the test command to it. When it responds by changing
+the command to noop, the OS is not required to maintain the mailbox reset environment for the given
+application processor any more.
 
 .. list-table:: **Multiprocessor Wakeup Structure**
    :name: multiprocessor-wakeup-structure-table
@@ -4507,11 +4527,11 @@ For each application processor, the mail
    * - Length
      - 1
      - 1
-     - 16
+     - 24
    * - MailBoxVersion
      - 2
      - 2
-     - Version of the mailbox. 0 for this version of the spec.
+     - Version of the mailbox. 1 for this version of the spec.
    * - *Reserved*
      - 4
      - 4
@@ -4520,6 +4540,17 @@ For each application processor, the mail
      - 8
      - 8
      - Physical address of the mailbox. It must be in ACPINvs. It must also be 4K bytes aligned. See :numref:`multiprocessor-wakeup-mailbox-structure` for the Mailbox definition. 
+   * - ResetVector
+     - 8
+     - 16
+     - | The mailbox reset vector address for application processor(s).
+       | For Intel processors, the mailbox reset environment is:
+       |   Interrupts must be disabled.
+       |   RFLAGES.IF set to 0.
+       |   Long mode enabled.
+       |   Paging mode is enabled and physical memory for reset vector is identity mapped (virtual address equals physical address).
+       |   Reset vector must be contained within one physical page.
+       |   Selectors are set to flat and otherwise not used.
 
 .. list-table:: **Multiprocessor Wakeup Mailbox Structure**
    :name: multiprocessor-wakeup-mailbox-structure
@@ -4536,7 +4567,8 @@ For each application processor, the mail
      - 0
      - | 0: Noop - no operation.
        | 1: Wakeup – jump to the wakeup vector.
-       | 2-0xFFFF: Reserved 
+       | 2: Test - respond by changing the command to Noop.
+       | 3-0xFFFF: Reserved.
    * - *Reserved*
      - 2
      - 2



