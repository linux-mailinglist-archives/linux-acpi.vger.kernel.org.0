Return-Path: <linux-acpi+bounces-40-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37B37A9C42
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 21:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 592F3282AE6
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 19:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87E05A898
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 18:43:59 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F238D43AB3
	for <linux-acpi@vger.kernel.org>; Thu, 21 Sep 2023 18:10:59 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A52A6B77;
	Thu, 21 Sep 2023 11:00:29 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id af288fc4f0608954; Thu, 21 Sep 2023 16:00:28 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by v370.home.net.pl (Postfix) with ESMTPSA id BA3E1664E61;
	Thu, 21 Sep 2023 16:00:27 +0200 (CEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Michal Wilczynski <michal.wilczynski@intel.com>, Guenter Roeck <linux@roeck-us.net>, Frank Scheiner <frank.scheiner@web.de>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1] ACPI: processor: Provide empty stub of acpi_proc_quirk_mwait_check()
Date: Thu, 21 Sep 2023 16:00:27 +0200
Message-ID: <5724231.DvuYhMxLoT@kreacher>
In-Reply-To: <CAMj1kXHpVroVqXxH72XNJP5=dYDcfBiZex2wE2jOsSFNEAYqxg@mail.gmail.com>
References: <12299447.O9o76ZdvQC@kreacher> <CAMj1kXHpVroVqXxH72XNJP5=dYDcfBiZex2wE2jOsSFNEAYqxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrudekiedgjedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepfeduudeutdeugfelffduieegiedtueefledvjeegffdttefhhffhtefhleejgfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhgrlhdrfihilhgtiiihnhhskhhisehi
 nhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugiesrhhovggtkhdquhhsrdhnvghtpdhrtghpthhtohepfhhrrghnkhdrshgthhgvihhnvghrseifvggsrdguvg
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thursday, September 21, 2023 3:09:04 PM CEST Ard Biesheuvel wrote:
> On Thu, 21 Sept 2023 at 13:04, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Commit 0a0e2ea642f6 ("ACPI: processor: Move MWAIT quirk out of
> > acpi_processor.c") added acpi_proc_quirk_mwait_check() that is
> > only defined for x86 and is unlikely to be defined for any other
> > architectures, so put it under #ifdef CONFIG_X86 and provide
> > an empty stub implementation of it for the other cases.
> >
> > Link: https://lore.kernel.org/lkml/c7a05a44-c0be-46c2-a21d-b242524d482b@roeck-us.net
> > Link: https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?h=remove-ia64&id=a0334bf78b95532cec54f56b53e8ae1bfe7e1ca1
> > Fixes: 0a0e2ea642f6 ("ACPI: processor: Move MWAIT quirk out of acpi_processor.c")
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Reported-by: Frank Scheiner <frank.scheiner@web.de>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > This is kind of orthogonal to
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?h=remove-ia64&id=a0334bf78b95532cec54f56b53e8ae1bfe7e1ca1
> >
> > because if any architectures other than x86 and ia64 decide to use the
> > processor _OSC, they will see the reported build error.
> >
> 
> You mean when other arches #define CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC too, right?
> 
> In any case, this is going to conflict with my change, which is
> already in linux-next (you were cc'ed on the PR to asm-generic). What
> do you propose here?

IIUC, the conflict is that the empty stub will be defined twice if this is
applied before removing ia64.

But if it is applied on top of the ia64 removal, all should be fine, so that's
what I would do (and tell the -stable people to ignore it).
 
> > ---
> >  drivers/acpi/internal.h |   14 ++++----------
> >  1 file changed, 4 insertions(+), 10 deletions(-)
> >
> > Index: linux-pm/drivers/acpi/internal.h
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/internal.h
> > +++ linux-pm/drivers/acpi/internal.h
> > @@ -148,8 +148,11 @@ int acpi_wakeup_device_init(void);
> >  #ifdef CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC
> >  void acpi_early_processor_control_setup(void);
> >  void acpi_early_processor_set_pdc(void);
> > -
> > +#ifdef CONFIG_X86
> >  void acpi_proc_quirk_mwait_check(void);
> > +#else
> > +static inline void acpi_proc_quirk_mwait_check(void) {}
> > +#endif
> >  bool processor_physically_present(acpi_handle handle);
> >  #else
> >  static inline void acpi_early_processor_control_setup(void) {}
> >
> >
> >
> 





