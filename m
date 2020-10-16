Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9762290A5F
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Oct 2020 19:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732607AbgJPRPY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Oct 2020 13:15:24 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56414 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732605AbgJPRPY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Oct 2020 13:15:24 -0400
Received: from 89-64-86-149.dynamic.chello.pl (89.64.86.149) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.491)
 id 922e8bd7e753c80b; Fri, 16 Oct 2020 19:15:21 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: Re: [PATCH 4/6] ACPICA: Add support for using logical addresses of GPE blocks
Date:   Fri, 16 Oct 2020 19:15:20 +0200
Message-ID: <1735226.fPvPZg4QOa@kreacher>
In-Reply-To: <3b69e0d0-fb8a-92b4-42fd-f2a8fcdd642b@tessares.net>
References: <1748021.N9i9sLPJ40@kreacher> <9373262.piL2bvXoCD@kreacher> <3b69e0d0-fb8a-92b4-42fd-f2a8fcdd642b@tessares.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Friday, October 16, 2020 4:30:55 PM CEST Matthieu Baerts wrote:
> Hi Rafael,

Hi,

> On 04/09/2020 19:24, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > 
> > The logical address of every GPE block in system memory must be
> > known before passing it to acpi_ev_initialize_gpe_block(), because
> > memory cannot be mapped on the fly from an interrupt handler.
> > Accordingly, the host OS must map every GPE block in system
> > memory upfront and it can store the logical addresses of GPE
> > blocks for future use.
> 
> (...)
> 
> > diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
> > index a0e71f34c77a..37bb67ef3232 100644
> > --- a/drivers/acpi/acpica/hwgpe.c
> > +++ b/drivers/acpi/acpica/hwgpe.c
> > @@ -46,8 +46,13 @@ acpi_status acpi_hw_gpe_read(u64 *value, struct acpi_gpe_address *reg)
> >   	u32 value32;
> >   
> >   	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
> > +#ifdef ACPI_GPE_USE_LOGICAL_ADDRESSES
> > +		*value = (u64)ACPI_GET8(reg->address);
> 
> Thank you for the patch!
> 
> When compiling net-next repo, recently sync with Linus repo, I got an 
> error when using i386 arch because of this line above.
> 
> Here are the commands I used:
> 
> 
> ================================================
> $ make defconfig KBUILD_DEFCONFIG=i386_defconfig
> *** Default configuration is based on 'i386_defconfig'
> #
> # configuration written to .config
> #
> $ scripts/config --disable DRM --disable PCCARD --disable ATA --disable 
> MD --disable PPS --disable SOUND --disable USB --disable IOMMU_SUPPORT 
> --disable INPUT_LEDS --disable AGP --disable VGA_ARB --disable EFI 
> --disable WLAN --disable WIRELESS --disable LOGO --disable NFS_FS 
> --disable XFRM_USER --disable INET6_AH --disable INET6_ESP --disable 
> NETDEVICES -e KUNIT -d KUNIT_DEBUGFS -d KUNIT_TEST -d KUNIT_EXAMPLE_TEST 
> -d EXT4_KUNIT_TESTS -d SYSCTL_KUNIT_TEST -d LIST_KUNIT_TEST -d 
> LINEAR_RANGES_TEST -d BITS_TEST -d KUNIT_ALL_TESTS -e INET_DIAG -d 
> INET_UDP_DIAG -d INET_RAW_DIAG -d INET_DIAG_DESTROY -e MPTCP -e 
> MPTCP_IPV6 -e MPTCP_KUNIT_TESTS
> $ KCFLAGS=-Werror make -j8 -l8
> scripts/kconfig/conf  --syncconfig Kconfig
> (...)
>    CC      drivers/acpi/acpica/hwgpe.o
> In file included from ./include/acpi/acpi.h:24,
>                   from drivers/acpi/acpica/hwgpe.c:10:
> drivers/acpi/acpica/hwgpe.c: In function 'acpi_hw_gpe_read':
> ./include/acpi/actypes.h:501:48: error: cast to pointer from integer of 
> different size [-Werror=int-to-pointer-cast]
>    501 | #define ACPI_CAST_PTR(t, p)             ((t *) (acpi_uintptr_t) 
> (p))
>        |                                                ^
> drivers/acpi/acpica/acmacros.h:18:41: note: in expansion of macro 
> 'ACPI_CAST_PTR'
>     18 | #define ACPI_CAST8(ptr)                 ACPI_CAST_PTR (u8, (ptr))
>        |                                         ^~~~~~~~~~~~~
> drivers/acpi/acpica/acmacros.h:22:43: note: in expansion of macro 
> 'ACPI_CAST8'
>     22 | #define ACPI_GET8(ptr)                  (*ACPI_CAST8 (ptr))
>        |                                           ^~~~~~~~~~
> drivers/acpi/acpica/hwgpe.c:50:17: note: in expansion of macro 'ACPI_GET8'
>     50 |   *value = (u64)ACPI_GET8(reg->address);
>        |                 ^~~~~~~~~
> drivers/acpi/acpica/hwgpe.c: In function 'acpi_hw_gpe_write':
> ./include/acpi/actypes.h:501:48: error: cast to pointer from integer of 
> different size [-Werror=int-to-pointer-cast]
>    501 | #define ACPI_CAST_PTR(t, p)             ((t *) (acpi_uintptr_t) 
> (p))
>        |                                                ^
> drivers/acpi/acpica/acmacros.h:18:41: note: in expansion of macro 
> 'ACPI_CAST_PTR'
>     18 | #define ACPI_CAST8(ptr)                 ACPI_CAST_PTR (u8, (ptr))
>        |                                         ^~~~~~~~~~~~~
> drivers/acpi/acpica/acmacros.h:26:43: note: in expansion of macro 
> 'ACPI_CAST8'
>     26 | #define ACPI_SET8(ptr, val)             (*ACPI_CAST8 (ptr) = 
> (u8) (val))
>        |                                           ^~~~~~~~~~
> drivers/acpi/acpica/hwgpe.c:85:3: note: in expansion of macro 'ACPI_SET8'
>     85 |   ACPI_SET8(reg->address, value);
>        |   ^~~~~~~~~
> cc1: all warnings being treated as errors

This is what causes the build to terminate.

> make[3]: *** [scripts/Makefile.build:283: drivers/acpi/acpica/hwgpe.o] 
> Error 1
> make[2]: *** [scripts/Makefile.build:500: drivers/acpi/acpica] Error 2
> make[1]: *** [scripts/Makefile.build:500: drivers/acpi] Error 2
> make: *** [Makefile:1777: drivers] Error 2
> ================================================
> 
> 
> > +		return_ACPI_STATUS(AE_OK);
> > +#else
> >   		return acpi_os_read_memory((acpi_physical_address)reg->address,
> >   					    value, ACPI_GPE_REGISTER_WIDTH);
> > +#endif
> >   	}
> >   
> >   	status = acpi_os_read_port((acpi_io_address)reg->address,
> > @@ -76,8 +81,13 @@ acpi_status acpi_hw_gpe_read(u64 *value, struct acpi_gpe_address *reg)
> >   acpi_status acpi_hw_gpe_write(u64 value, struct acpi_gpe_address *reg)
> >   {
> >   	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
> > +#ifdef ACPI_GPE_USE_LOGICAL_ADDRESSES
> > +		ACPI_SET8(reg->address, value);
> 
> (and also because of this line)
> 
> By chance, do you already have a fix for that?

Can you please try the appended patch?

> I didn't see any other 
> email related to this issue, I am surprised no bot already reported the 
> problem but maybe I didn't look everywhere :)

No, they didn't AFAICS.

---
 drivers/acpi/acpica/hwgpe.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/acpi/acpica/hwgpe.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/hwgpe.c
+++ linux-pm/drivers/acpi/acpica/hwgpe.c
@@ -47,7 +47,7 @@ acpi_status acpi_hw_gpe_read(u64 *value,
 
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
 #ifdef ACPI_GPE_USE_LOGICAL_ADDRESSES
-		*value = (u64)ACPI_GET8(reg->address);
+		*value = (u64)ACPI_GET8((unsigned long)reg->address);
 		return_ACPI_STATUS(AE_OK);
 #else
 		return acpi_os_read_memory((acpi_physical_address)reg->address,
@@ -82,7 +82,7 @@ acpi_status acpi_hw_gpe_write(u64 value,
 {
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
 #ifdef ACPI_GPE_USE_LOGICAL_ADDRESSES
-		ACPI_SET8(reg->address, value);
+		ACPI_SET8((unsigned long)reg->address, value);
 		return_ACPI_STATUS(AE_OK);
 #else
 		return acpi_os_write_memory((acpi_physical_address)reg->address,



