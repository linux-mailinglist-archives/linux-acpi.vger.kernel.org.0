Return-Path: <linux-acpi+bounces-8590-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D783993738
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Oct 2024 21:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928381F23A63
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Oct 2024 19:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB251DDC17;
	Mon,  7 Oct 2024 19:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="X/mudOIA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QN++mMqm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1CB13B797;
	Mon,  7 Oct 2024 19:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728328989; cv=none; b=jWdmOJrH9Cd6FWF/OBkeqKgt0xToviNR/BdgZMiNlbj5L4T/xYX+fw/Eg/wRt2TE8N66LfgFKDgWsZdlXgseDpZxPuUkPnGibgwMZpX6iPxfkZLVXQoWWM+JgxZ21Zw4JjQ/qrooK8ru4JkaFzzJgJTuh05J/JZttR/hfmy30Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728328989; c=relaxed/simple;
	bh=1LY4BGcMcs7/LpY3RmUIikPRuPqW8JaQcxHkzcYCGFo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=d903+UHI7JNf62kGcWKC+PwFYAB6FyWDBru13cKdj0GxXroWHVkUmBfeSWW5PvtfH+o2fWRVGLQaRHT2E6Ar6LADqS6BpWhGolkoIubbkr1hVqoTpsEtTdy0dHRC2Ktsl2tp4C+Fw5h9c9CmwxID00ejddyKs6W2/YDn4wn5QyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=X/mudOIA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QN++mMqm; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id CAC111380208;
	Mon,  7 Oct 2024 15:23:05 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 07 Oct 2024 15:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728328985;
	 x=1728415385; bh=ybMwGV/+/3v9W/4x75Ns1/jnoGPLxucLg3bPgg1yBc8=; b=
	X/mudOIAzUR+OqmV4vumrqVUJ3KvGZjGLI+Oh2rx+jBcQi1HvBtI0y0yyECl4EBM
	FuvBfVS+v2PwUkbizumIzPxplhHY6iVYE/0G526elGFMY6XvY0gpusEPX6TeC+IR
	+b14hfpFfmpGqzlsh7ccD37Jiz3cRJBi6/Z1GkUNqL/er1IBT2ZD/LKW8fgWzBT6
	/1+7rsEeKig9zH7anxN0korc5KhUtZ02wGN1V46eOb6Gm3TMzbUGVNcFHJg/HCym
	fsRKsRjSviW+XeAhCiSnIdpAzCQllVIwab3Pg0lJ6mzd7k3tB54bLdUKAO0HPXyP
	7OFIhkePw8Z50+UtyB3tZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728328985; x=
	1728415385; bh=ybMwGV/+/3v9W/4x75Ns1/jnoGPLxucLg3bPgg1yBc8=; b=Q
	N++mMqmWEmWc7+zOfSTO4zUVFRUmEOGvfo+hTKtjeP2u0/8haYIjsewuuMp/ajoo
	Xwo12USvtSeSIKFU+LWIzxLhlH6dlViWfYNohViJOuCQhxTeFZGYhLArb0wEQoeE
	KOgdZ3EZc7KFPM2luvhGqdAPIHowfjxxPwX5ft+3evJxUql5k9AZGtxx4448TeiY
	QMsO4rkRH/agW9ByX23Iwd1N4J8kQncfYcOQaRJ9TOrHXFw4sc0M01c/wdpUi8kR
	mRqZZEKRBBkmrc9AU+/m/BasJw82EYeV6v906wPzwWIkO73b2XlpuegrM5Y6iYVC
	2o6n9rCmHPXqAt2CnQ8pQ==
X-ME-Sender: <xms:FzUEZzaGu-4T6HHkZB_H9b6DYFtFiQheTg4DbCb0ieqFGYPKP830hQ>
    <xme:FzUEZybFKvbrGoC59GK93kDrhPo_GxVFBjlomzBQc7pyJzeoFfUKewWz3cUmjeOEr
    Ijep8HGfxNnXatbzno>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvleehvddv
    geejvdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpd
    hrtghpthhtohepjhgrmhgvshdrmhhorhhsvgesrghrmhdrtghomhdprhgtphhtthhopehj
    ohhnrghthhgrnhdrtggrmhgvrhhonheshhhurgifvghirdgtohhmpdhrtghpthhtoheprh
    hosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepthhonhihrdhl
    uhgtkhesihhnthgvlhdrtghomhdprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhgvnhgssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghf
    rggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgthhhnvghllhgvsehlihhnuh
    igrdhisghmrdgtohhm
X-ME-Proxy: <xmx:GDUEZ19tvuchl0O9c00KA-ezXqdKtKDFDh7XlAPG0iYDgCN8qiXS6Q>
    <xmx:GDUEZ5pXzzxRzT1YTJqQ2aTih39ZryJh70f_T9-Bqcqq3v2fkpFzQw>
    <xmx:GDUEZ-psOLeiizDc464FCvkT2oSVTH5DqK6sPtP2I7Y1R8um-IhZUw>
    <xmx:GDUEZ_Q3f4nhHOfhMTzpSeIpwDWpIxjht47LbHK11wsS-m4BaWz-SQ>
    <xmx:GTUEZz55nL4HknLe6IbxRBLKhtuMd04lXRM2UJFu7cAv6_kcA4zN75ug>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DBEAE2220071; Mon,  7 Oct 2024 15:23:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 07 Oct 2024 19:22:39 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Robert Moore" <robert.moore@intel.com>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>, "Len Brown" <lenb@kernel.org>,
 "James Morse" <james.morse@arm.com>, "Tony Luck" <tony.luck@intel.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 "Sunil V L" <sunilvl@ventanamicro.com>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 acpica-devel@lists.linux.dev
Message-Id: <641307d3-3fe5-401a-ba22-96ad5ef25fed@app.fastmail.com>
In-Reply-To: 
 <CAJZ5v0immr4obYsu2qNKKY2DKxzLDR1a=6B4xY_YTHfPF5kADg@mail.gmail.com>
References: <20241004204845.970951-1-arnd@kernel.org>
 <CAJZ5v0immr4obYsu2qNKKY2DKxzLDR1a=6B4xY_YTHfPF5kADg@mail.gmail.com>
Subject: Re: [PATCH] acpi: allow building without CONFIG_HAS_IOPORT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024, at 16:04, Rafael J. Wysocki wrote:
> On Fri, Oct 4, 2024 at 10:48=E2=80=AFPM Arnd Bergmann <arnd@kernel.org=
> wrote:
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> CONFIG_HAS_IOPORT will soon become optional and cause a build time
>> failure when it is disabled but a driver calls inb()/outb(). At the
>> moment, all architectures that can support ACPI have port I/O, but
>> this is not necessarily the case in the future.
>
> Can addressing this be deferred to that point?

Yes. I would like to have all of arm64 and riscv be able to turn
off HAS_IOPORT eventually, but nothing depends on doing this
when ACPI is enabled.

>> Since the embedded controller can only exist when port I/O is
>> active, it makes sense to disable that code on targets that don't
>> have it. The same is true for anything using acpi_os_read_port()
>> and similar functions.
>>
>> Add compile-time conditionals around all of those and their callers.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> Should this be split up into smaller patches?
>
> No need, but the ACPICA part is kind of nasty.

Right, I see.

>> --- a/drivers/acpi/acpica/evhandler.c
>> +++ b/drivers/acpi/acpica/evhandler.c
>> @@ -358,12 +358,13 @@ acpi_ev_install_space_handler(struct acpi_names=
pace_node *node,
>>                         handler =3D acpi_ex_system_memory_space_handl=
er;
>>                         setup =3D acpi_ev_system_memory_region_setup;
>>                         break;
>> -
>> +#ifdef CONFIG_HAS_IOPORT
>>                 case ACPI_ADR_SPACE_SYSTEM_IO:
>>
>>                         handler =3D acpi_ex_system_io_space_handler;
>>                         setup =3D acpi_ev_io_space_region_setup;
>>                         break;
>> +#endif
>
> All changes like the above in the ACPICA code potentially increase the
> number of times when upstream ACPICA patches will have to be ported to
> Linux manually, which in turn increases the number of potential
> mistakes in the process.
>
> I'd rather avoid making them, if possible.

Understood. Does that mean that on the flip-side we can change
the drivers/acpi/osl.c portion to turn acpi_os_read_port()
and acpi_os_write_port() into a runtime error for configurations
without port I/O, without causing the same maintenance overhead?

The version below builds fine and doesn't touch acpica but
it's a bit harder to predict what would happen at runtime.

      Arnd


diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index b8924077163b..5ec58c4e0332 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -134,6 +134,7 @@ config ACPI_REV_OVERRIDE_POSSIBLE
=20
 config ACPI_EC_DEBUGFS
 	tristate "EC read/write access through /sys/kernel/debug/ec"
+	depends on HAS_IOPORT
 	help
 	  Say N to disable Embedded Controller /sys/kernel/debug interface
=20
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 61ca4afe83dc..132357815324 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -41,7 +41,7 @@ acpi-y				+=3D resource.o
 acpi-y				+=3D acpi_processor.o
 acpi-y				+=3D processor_core.o
 acpi-$(CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC) +=3D processor_pdc.o
-acpi-y				+=3D ec.o
+acpi-$(CONFIG_HAS_IOPORT)	+=3D ec.o
 acpi-$(CONFIG_ACPI_DOCK)	+=3D dock.o
 acpi-$(CONFIG_PCI)		+=3D pci_root.o pci_link.o pci_irq.o
 obj-$(CONFIG_ACPI_MCFG)		+=3D pci_mcfg.o
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 16917dc3ad60..535d6a72ce1b 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1356,7 +1356,8 @@ static int __init acpi_bus_init(void)
 	 * Do that before calling acpi_initialize_objects() which may trigger =
EC
 	 * address space accesses.
 	 */
-	acpi_ec_ecdt_probe();
+	if (IS_ENABLED(CONFIG_HAS_IOPORT))
+		acpi_ec_ecdt_probe();
=20
 	status =3D acpi_enable_subsystem(ACPI_NO_ACPI_ENABLE);
 	if (ACPI_FAILURE(status)) {
@@ -1391,7 +1392,8 @@ static int __init acpi_bus_init(void)
 	 * Maybe EC region is required at bus_scan/acpi_get_devices. So it
 	 * is necessary to enable it as early as possible.
 	 */
-	acpi_ec_dsdt_probe();
+	if (IS_ENABLED(CONFIG_HAS_IOPORT))
+		acpi_ec_dsdt_probe();
=20
 	pr_info("Interpreter enabled\n");
=20
@@ -1464,7 +1466,8 @@ static int __init acpi_init(void)
 	acpi_arm_init();
 	acpi_riscv_init();
 	acpi_scan_init();
-	acpi_ec_init();
+	if (IS_ENABLED(CONFIG_HAS_IOPORT))
+		acpi_ec_init();
 	acpi_debugfs_init();
 	acpi_sleep_proc_init();
 	acpi_wakeup_device_init();
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index b73b3aa92f3f..326b73ae77a9 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1017,7 +1017,8 @@ static int cpc_read(int cpu, struct cpc_register_r=
esource *reg_res, u64 *val)
 	*val =3D 0;
 	size =3D GET_BIT_WIDTH(reg);
=20
-	if (reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_IO) {
+	if (IS_ENABLED(CONFIG_HAS_IOPORT) &&
+	    reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_IO) {
 		u32 val_u32;
 		acpi_status status;
=20
@@ -1090,7 +1091,8 @@ static int cpc_write(int cpu, struct cpc_register_=
resource *reg_res, u64 val)
=20
 	size =3D GET_BIT_WIDTH(reg);
=20
-	if (reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_IO) {
+	if (IS_ENABLED(CONFIG_HAS_IOPORT) &&
+	    reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_IO) {
 		acpi_status status;
=20
 		status =3D acpi_os_write_port((acpi_io_address)reg->address,
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 78a81969d90e..04d3864073ba 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -642,6 +642,11 @@ acpi_status acpi_os_read_port(acpi_io_address port,=
 u32 *value, u32 width)
 {
 	u32 dummy;
=20
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT)) {
+		*value =3D BIT_MASK(width);
+		return AE_NOT_IMPLEMENTED;
+	}
+
 	if (value)
 		*value =3D 0;
 	else
@@ -665,6 +670,9 @@ EXPORT_SYMBOL(acpi_os_read_port);
=20
 acpi_status acpi_os_write_port(acpi_io_address port, u32 value, u32 wid=
th)
 {
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return AE_NOT_IMPLEMENTED;
+
 	if (width <=3D 8) {
 		outb(value, port);
 	} else if (width <=3D 16) {
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_p=
erflib.c
index 4265814c74f8..8be453d89ef8 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -455,7 +455,8 @@ int acpi_processor_pstate_control(void)
 {
 	acpi_status status;
=20
-	if (!acpi_gbl_FADT.smi_command || !acpi_gbl_FADT.pstate_control)
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT) ||
+	    !acpi_gbl_FADT.smi_command || !acpi_gbl_FADT.pstate_control)
 		return 0;
=20
 	pr_debug("Writing pstate_control [0x%x] to smi_command [0x%x]\n",
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 7ecc401fb97f..9d5e6dd542bf 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2293,7 +2293,8 @@ static int acpi_bus_attach(struct acpi_device *dev=
ice, void *first_pass)
 	if (device->handler)
 		goto ok;
=20
-	acpi_ec_register_opregions(device);
+	if (IS_ENABLED(CONFIG_HAS_IOPORT))
+		acpi_ec_register_opregions(device);
=20
 	if (!device->flags.initialized) {
 		device->flags.power_manageable =3D

