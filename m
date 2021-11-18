Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55E2455E96
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 15:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhKROyL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Nov 2021 09:54:11 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:45744 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhKROyL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Nov 2021 09:54:11 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.1)
 id 205ac57e45ce267f; Thu, 18 Nov 2021 15:51:09 +0100
Received: from kreacher.localnet (unknown [213.134.175.214])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id D208966AB38;
        Thu, 18 Nov 2021 15:51:08 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 5.16 regression fix 0/5] ACPI: scan: Skip turning off some unused objects during scan
Date:   Thu, 18 Nov 2021 15:51:08 +0100
Message-ID: <4363288.LvFx2qVVIh@kreacher>
In-Reply-To: <937cf1fd-0cb1-1a12-7745-8cc2a2e3405a@redhat.com>
References: <20211117220118.408953-1-hdegoede@redhat.com> <CAJZ5v0hDWN4cKh+ZcB__wrWHChm=FjhwvCShXzseECQOFotM6w@mail.gmail.com> <937cf1fd-0cb1-1a12-7745-8cc2a2e3405a@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.214
X-CLIENT-HOSTNAME: 213.134.175.214
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrfeeigdeihecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepkeeftefhueeujedvveehieekkeekudfhudfgvdeuudegieelvdefkeetveeivddunecuffhomhgrihhnpehfvgguohhrrghpvghophhlvgdrohhrghenucfkphepvddufedrudefgedrudejhedrvddugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddujeehrddvudegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprggurhhirghnrdhhuhhnthgvrhesihhnthgvlhdrtghomhdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehlvghn
 sgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhmtgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thursday, November 18, 2021 12:15:28 PM CET Hans de Goede wrote:
> Hi,
> 
> On 11/18/21 12:08, Rafael J. Wysocki wrote:
> > On Wed, Nov 17, 2021 at 11:01 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi Rafael,
> >>
> >> Commit c10383e8ddf4 ("ACPI: scan: Release PM resources blocked by
> >> unused objects") adds a:
> >>
> >>         bus_for_each_dev(&acpi_bus_type, NULL, NULL, acpi_dev_turn_off_if_unused);
> >>
> >> call to acpi_scan_init(). On some devices with buggy DSDTs calling
> >> _PS3 for one device may result in it turning off another device.
> > 
> > Well, I'm going to revert this commit.  I'm sending a pull request
> > with the revert later today.
> > 
> >> Specifically the DSDT of the GPD win and GPD pocket devices has a
> >> "\\_SB_.PCI0.SDHB.BRC1" device for a non existing SDIO wifi module
> >> which _PS3 method sets a GPIO causing the PCI wifi card to turn off.
> >>
> >> I've an earlier, in some ways simpler, fix for this here:
> >> https://fedorapeople.org/~jwrdegoede/0001-ACPI-scan-Skip-turning-off-some-unused-objects-durin.patch
> >>
> >> But the sdhci-acpi.c MMC host code already has an older workaround
> >> for it to not toggle power on this broken ACPI object; and this
> >> simpler fix would require keeping that workaround. So then we would
> >> have 2 workarounds for the same issue in the kernel.
> >>
> >> Thus instead I've come up with a slightly different approach which
> >> IMHO has ended up pretty well.
> >>
> >> Patches 1-3 of this series are this different approach and assuming
> >> they are considered ok must be merged into 5.16 to fix the regression
> >> caused by commit c10383e8ddf4 on these devices.
> > 
> > So I'll have a look at these and if they look good, we can do that
> > instead of the problematic commit in 5.17.
> 
> I'm a bit confused now, if the problematic commit is going to get
> reversed then technically we don't need this series anymore ?

That's correct.

> Or are you planning on re-introducing it in some form for 5.17 ?

I have been considering this.

> With that said getting this series merged would still be good,
> patch 1 + 2 make the existing always_present quirk code more generic
> which might be useful later. And then patch 3 (which is small)
> allows dropping some ugliness from the sdhci-acpi.c code since
> the DSDT bug we are hitting will now be solved by the
> new acpi-dev-status-override mechanism.

OK, so this would be applicable for 5.17, but a couple of changelogs
need to be updated if I'm not mistaken.

Can you please do that and resend the series?



