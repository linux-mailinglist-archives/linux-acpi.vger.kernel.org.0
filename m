Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A9333F9CF
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Mar 2021 21:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbhCQUO5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Mar 2021 16:14:57 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42072 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbhCQUOm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Mar 2021 16:14:42 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.3)
 id 333110543e0e6429; Wed, 17 Mar 2021 21:14:41 +0100
Received: from kreacher.localnet (89-64-80-90.dynamic.chello.pl [89.64.80.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id AA602668ED9;
        Wed, 17 Mar 2021 21:14:38 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        George Kennedy <george.kennedy@oracle.com>,
        Robert Moore <robert.moore@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/1] ACPI: fix acpi table use after free
Date:   Wed, 17 Mar 2021 21:14:37 +0100
Message-ID: <3236337.DtqTXxM43S@kreacher>
In-Reply-To: <CAJZ5v0g1H6hCVbAAFajhn0AYRMU4GkZOqggOB6LVdgFx_vfwOA@mail.gmail.com>
References: <CAJZ5v0j3=82x1hV9SCdinJQPkDXmJd9BFoqvNxNHSb6iS8PHVQ@mail.gmail.com> <YE5dJ6U3nPWsXY4D@linux.ibm.com> <CAJZ5v0g1H6hCVbAAFajhn0AYRMU4GkZOqggOB6LVdgFx_vfwOA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrudefgedgudeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttddvnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgfelheffhfetffelhfelteejffetteetgfetkeejvdfhfeeftdeufeevgeevieevnecukfhppeekledrieegrdektddrledtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedtrdeltddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehrphhptheslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopegvrhhikhdrkhgrnhgvuggrsehinhhtvghlrdgtohhmpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtghomhdprhgtphhtthhopehgvghorhhgvgdrkhgvnhhnvgguhiesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheprhhosggvrhhtrdhmohho
 rhgvsehinhhtvghlrdgtohhmpdhrtghpthhtoheprhgrfhgrvghlrdhjrdifhihsohgtkhhisehinhhtvghlrdgtohhmpdhrtghpthhtoheplhgvnhgssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvghvvghlsegrtghpihgtrgdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkohhnrhgrugdrfihilhhksehorhgrtghlvgdrtghomhdprhgtphhtthhopegurghnrdgtrghrphgvnhhtvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopeguhhgrvhgrlhdrghhirghnihesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehvsggrsghkrgesshhushgvrdgtiidprhgtphhtthhopehoshgrlhhvrgguohhrsehsuhhsvgdruggvpdhrtghpthhtoheprhhitghhrghrugdrfigvihihrghngheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehprghnkhgrjhdrghhuphhtrgdrlhhinhhugiesghhmrghilhdrtghomhdprhgtphhtthhopehmhhhotghkohesshhushgvrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=20 Fuz1=20 Fuz2=20
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Monday, March 15, 2021 5:19:29 PM CET Rafael J. Wysocki wrote:
> On Sun, Mar 14, 2021 at 8:00 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > On Thu, Mar 11, 2021 at 04:36:31PM +0100, Rafael J. Wysocki wrote:
> > > On Wed, Mar 10, 2021 at 8:47 PM David Hildenbrand <david@redhat.com> wrote:
> > > > >
> > > > > There is some care that should be taken to make sure we get the order
> > > > > right, but I don't see a fundamental issue here.
> > >
> > > Me neither.
> > >
> > > > > If I understand correctly, Rafael's concern is about changing the parts of
> > > > > ACPICA that should be OS agnostic, so I think we just need another place to
> > > > > call memblock_reserve() rather than acpi_tb_install_table_with_override().
> > >
> > > Something like this.
> > >
> > > There is also the problem that memblock_reserve() needs to be called
> > > for all of the tables early enough, which will require some reordering
> > > of the early init code.
> > >
> > > > > Since the reservation should be done early in x86::setup_arch() (and
> > > > > probably in arm64::setup_arch()) we might just have a function that parses
> > > > > table headers and reserves them, similarly to how we parse the tables
> > > > > during KASLR setup.
> > >
> > > Right.
> >
> > I've looked at it a bit more and we do something like the patch below that
> > nearly duplicates acpi_tb_parse_root_table() which is not very nice.
> 
> It looks to me that the code need not be duplicated (see below).
> 
> > Besides, reserving ACPI tables early and then calling acpi_table_init()
> > (and acpi_tb_parse_root_table() again would mean doing the dance with
> > early_memremap() twice for no good reason.
> 
> That'd be simply inefficient which is kind of acceptable to me to start with.
> 
> And I changing the ACPICA code can be avoided at least initially, it
> by itself would be a good enough reason.
> 
> > I believe the most effective way to deal with this would be to have a
> > function that does parsing, reservation and installs the tables supplied by
> > the firmware which can be called really early and then another function
> > that overrides tables if needed a some later point.
> 
> I agree that this should be the direction to go into.

So maybe something like the patch below?

I'm not sure if acpi_boot_table_prepare() gets called early enough, though.

Also this still may not play well with initrd-based table overrides. Erik, do
you have any insights here?

And ia64 needs to be updated too.

---
 arch/x86/kernel/acpi/boot.c |   12 +++++++++---
 arch/x86/kernel/setup.c     |    3 +++
 drivers/acpi/tables.c       |   24 +++++++++++++++++++++---
 include/linux/acpi.h        |    9 +++++++--
 4 files changed, 40 insertions(+), 8 deletions(-)

Index: linux-pm/arch/x86/kernel/acpi/boot.c
===================================================================
--- linux-pm.orig/arch/x86/kernel/acpi/boot.c
+++ linux-pm/arch/x86/kernel/acpi/boot.c
@@ -1541,7 +1541,7 @@ static const struct dmi_system_id acpi_d
  *	...
  */
 
-void __init acpi_boot_table_init(void)
+void __init acpi_boot_table_prepare(void)
 {
 	dmi_check_system(acpi_dmi_table);
 
@@ -1554,10 +1554,16 @@ void __init acpi_boot_table_init(void)
 	/*
 	 * Initialize the ACPI boot-time table parser.
 	 */
-	if (acpi_table_init()) {
+	if (acpi_table_prepare())
 		disable_acpi();
+}
+
+void __init acpi_boot_table_init(void)
+{
+	if (acpi_disabled)
 		return;
-	}
+
+	acpi_table_init();
 
 	acpi_table_parse(ACPI_SIG_BOOT, acpi_parse_sbf);
 
Index: linux-pm/arch/x86/kernel/setup.c
===================================================================
--- linux-pm.orig/arch/x86/kernel/setup.c
+++ linux-pm/arch/x86/kernel/setup.c
@@ -1070,6 +1070,9 @@ void __init setup_arch(char **cmdline_p)
 	/* preallocate 4k for mptable mpc */
 	e820__memblock_alloc_reserved_mpc_new();
 
+	/* Look for ACPI tables and reserve memory occupied by them. */
+	acpi_boot_table_prepare();
+
 #ifdef CONFIG_X86_CHECK_BIOS_CORRUPTION
 	setup_bios_corruption_check();
 #endif
Index: linux-pm/include/linux/acpi.h
===================================================================
--- linux-pm.orig/include/linux/acpi.h
+++ linux-pm/include/linux/acpi.h
@@ -222,11 +222,13 @@ void __iomem *__acpi_map_table(unsigned
 void __acpi_unmap_table(void __iomem *map, unsigned long size);
 int early_acpi_boot_init(void);
 int acpi_boot_init (void);
+void acpi_boot_table_prepare (void);
 void acpi_boot_table_init (void);
 int acpi_mps_check (void);
 int acpi_numa_init (void);
 
-int acpi_table_init (void);
+int acpi_table_prepare (void);
+void acpi_table_init (void);
 int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
 int __init acpi_table_parse_entries(char *id, unsigned long table_size,
 			      int entry_id,
@@ -814,9 +816,12 @@ static inline int acpi_boot_init(void)
 	return 0;
 }
 
+static inline void acpi_boot_table_prepare(void)
+{
+}
+
 static inline void acpi_boot_table_init(void)
 {
-	return;
 }
 
 static inline int acpi_mps_check(void)
Index: linux-pm/drivers/acpi/tables.c
===================================================================
--- linux-pm.orig/drivers/acpi/tables.c
+++ linux-pm/drivers/acpi/tables.c
@@ -788,9 +788,10 @@ acpi_status acpi_os_table_override(struc
  * result: sdt_entry[] is initialized
  */
 
-int __init acpi_table_init(void)
+int __init acpi_table_prepare(void)
 {
 	acpi_status status;
+	int i;
 
 	if (acpi_verify_table_checksum) {
 		pr_info("Early table checksum verification enabled\n");
@@ -803,12 +804,29 @@ int __init acpi_table_init(void)
 	status = acpi_initialize_tables(initial_tables, ACPI_MAX_TABLES, 0);
 	if (ACPI_FAILURE(status))
 		return -EINVAL;
-	acpi_table_initrd_scan();
 
-	check_multiple_madt();
+	for (i = 0; i < ACPI_MAX_TABLES; i++) {
+		struct acpi_table_desc *table_desc = &initial_tables[i];
+
+		if (!table_desc->address || !table_desc->length)
+			break;
+
+		pr_info("Reserving %4s table memory at [0x%llx - 0x%llx]\n",
+			table_desc->signature.ascii, table_desc->address,
+			table_desc->address + table_desc->length - 1);
+
+		memblock_reserve(table_desc->address, table_desc->length);
+	}
+
 	return 0;
 }
 
+void __init acpi_table_init(void)
+{
+	acpi_table_initrd_scan();
+	check_multiple_madt();
+}
+
 static int __init acpi_parse_apic_instance(char *str)
 {
 	if (!str)



