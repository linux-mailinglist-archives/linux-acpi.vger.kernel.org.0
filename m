Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F58D72332C
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Jun 2023 00:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjFEW1E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Jun 2023 18:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjFEW1E (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jun 2023 18:27:04 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7729210D
        for <linux-acpi@vger.kernel.org>; Mon,  5 Jun 2023 15:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686004022; x=1717540022;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=MLoTeFVYxaw1KfVFoEk0dJm+KCJVsBiK2wqlhlW3JoQ=;
  b=X+zqN0F2dIqojFD3EbMKT7suuXbgPhrHagyaM75l2Q5aaQ/HK+f3pmMe
   KPbsZRTPCA3gOYbOnxF1PBrAgCXiEEon1DZeSKsjMiDxjJ7ATmEf5YhWI
   AcIHOlBq2rix7khgayEtLON02SVlBedEj2nsPK3QyLjCR4jhqMN/BfIEX
   7yzyyw1aMF8nLu8LnGHEyjivbaHPacQNTL2Ph4SRCaPxRqBDplu8/Wb7F
   B5RUrGrUirFifKu4ojqzBNP5ew83ofT722uM6sC8RclkYpq1S/dFN6bzW
   fkMsF1O5XsRxs/y3f9bbX+sYGNRKjZIQmw98XnSB0JzThL0OjRPnmZeOq
   g==;
IronPort-Data: A9a23:PzJiC6gvXwyzZ5mUqR8u3vD/X161khEKZh0ujC45NGQN5FlGYwR3i
 jdXHXbOJ7/bJjGtS21EGI229UsbyOW1t8sWOx8f8XxkVTdlkeeAAtLcL0HsMjmIM9XfCUJu6
 ckaa9/PaccySm6avh6xObiJQRJUhfHTG+qsWOObYXF7HlE4Q3Yv1kM4kORoi9U33YjoD1yB5
 YKsqZWHNgf5izQqbDJLs/7Y8Bkxtqz45WMR4lVkPpin0LOme1w9VfrzconrcienKmUtItOHe
 grj8F2Y1jiBpUl3UIr/nOelKhdSTu/YM1TShCoJV6Tz00EYr3Vjjv9rZfERVxxrhmTSlbid6
 jnsWb9c6+sNFvSUwIzxhjEBS3kW0YtupuGfeRBTluTKlxKdKRMA+903UAdse9dwFt9fWQlm7
 eYfJC0GcieNjue3xKPTYuR3j6zPFuGyVG8kki8mlWmx4coOG8iZGP2UvYIAhV/cu+gVdRrgT
 5tBAdZQREmYC/F/Eg9/II4zmu6umk7+f1VwwL5CjfFvi4R75FUZPInFaLI5SPTTLSlmth/wS
 lb9wojMKkpy2Oq3kmPZry321ocjqgugMG4aPOXQGveHGzR/zERLYPEdfQLTTfVUESdS8j+QQ
 qAZ0nNGkEQ8yKCkZvTAcTalhnWLhxgdaf5PC/w54R/X94OBtm51BkBcJtJAQNIjr8o5TGRyi
 hmHmpXoAyBitPueTnf1GrW89Gv0Y3VOazVeI3NUJecGy4CLTIUbjB/VQ9NyVqWyi8XyAi39x
 zSDhCk4m7gXy8UM0s1X+Hib2Wr0+sKWFFZdCgP/fGb/zjxEWNeZbLeatQnX9Px6N6jJdwzU1
 JQDs43EhAwUNrmXnSKETeElH7yz4fuBdjrGjjZS84IJ+TG2/nGqJdgMpj97YkZvLssAPzTuZ
 Sc/pD9s2XOaB1PyBYcfXm57I59CIXTIfTg9as3pUw==
IronPort-HdrOrdr: A9a23:inQo3apcl+DIGxAPPFvsEXgaV5oQeYIsimQD101hICG9vPb4qy
 nOpoVi6faaskdyZJhNo7+90ey7MBbhHP1OkPAs1NWZLW3bUbuTXedfBOLZqlWNJ8S9zJ8/6U
 4KSchD4bPLY2SSwfyKhzVQVOxK/DCAysrEudvj
X-Talos-CUID: 9a23:fXFnPG9TT+koA5xYT0KVv2MpNOs4VHbS9XHREWunEXdqQaPPdHbFrQ==
X-Talos-MUID: 9a23:hawIHAmcuiGLi8K/63RNdnpAMJ1I3JmSUXwGqqda6sWdPxZrFWek2WE=
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="420042721"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208,223";a="420042721"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 15:27:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="778739211"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208,223";a="778739211"
Received: from lrperezc-mobl1.amr.corp.intel.com (HELO jcompost-mobl.amr.corp.intel.com) ([10.212.57.112])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 15:27:00 -0700
From:   "Compostella, Jeremy" <jeremy.compostella@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     <linux-acpi@vger.kernel.org>
Subject: Re: ACPI: EC: Clear GPE on interrupt handling only
References: <87353x87p7.fsf@jcompost-mobl.amr.corp.intel.com>
        <CAJZ5v0gCcWJHkrf1zfcSJU1Aw1ZDEVkkTnvBFOpORJ6L0ji6UQ@mail.gmail.com>
        <CAJZ5v0jina9b4Yt9prEwbemyiGY2Q4psRawkwLZ+VKYY90R2xA@mail.gmail.com>
Date:   Mon, 05 Jun 2023 15:26:59 -0700
In-Reply-To: <CAJZ5v0jina9b4Yt9prEwbemyiGY2Q4psRawkwLZ+VKYY90R2xA@mail.gmail.com>
        (Rafael J. Wysocki's message of "Mon, 5 Jun 2023 18:26:45 +0200")
Message-ID: <87ilc1lf4c.fsf@jcompost-mobl.amr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Organization: Intel Corporation - 2200 Mission College Blvd. Santa Clara, CA
        95052. USA
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Rafael J. Wysocki" <rafael@kernel.org> writes:

> On Mon, Jun 5, 2023 at 6:14=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>>
>> On Tue, May 16, 2023 at 2:02=E2=80=AFAM Compostella, Jeremy
>> <jeremy.compostella@intel.com> wrote:
>> >
>> > On multiple devices I work on, we noticed that
>> > /sys/firmware/acpi/interrupts/sci_not is non-zero and keeps increasing
>> > over time.
>> >
>> > It turns out that there is a race condition between servicing a GPE
>> > interrupt and handling task driven transactions.
>> >
>> > If a GPE interrupt is received at the same time ec_poll() is running,
>> > the advance_transaction() clears the GPE flag and the interrupt is not
>> > serviced as acpi_ev_detect_gpe() relies on the GPE flag to call the
>> > handler. As a result, `sci_not' is increased.
>>
>> And if I'm not mistaken, it is not necessary to run the entire
>> interrupt handler in that case, because the currently running
>> advance_transaction() will take care of the pending event anyway.
>>
>> I agree that it is confusing to increase sci_not in that case, but I'm
>> not sure if running the entire advance_transaction() for the same
>> transaction twice in a row, once from ec_poll() and once from the
>> interrupt handler is entirely correct.
>
> However, if the interrupt handler wins the race, advance_transaction()
> will run for the same transaction twice in a row anyway, so this
> change will only make it happen more often.
>
> So no objections, but I would move the GPE clearing piece directly
> into acpi_ec_handle_interrupt(), because it will only be needed there
> and it doesn't depend on anything else in advance_transaction().

I took into account your suggestion (cf. patch in attachment).


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
 filename=0001-ACPI-EC-Clear-GPE-on-interrupt-handling-only.patch

From 42fa736fcd5d6a2e17c550f493a12e8df2e7cd72 Mon Sep 17 00:00:00 2001
From: Jeremy Compostella <jeremy.compostella@intel.com>
Date: Mon, 15 May 2023 16:49:19 -0700
Subject: [PATCH] ACPI: EC: Clear GPE on interrupt handling only

On multiple devices I work on, we noticed that
/sys/firmware/acpi/interrupts/sci_not is non-zero and keeps increasing
over time.

It turns out that there is a race condition between servicing a GPE
interrupt and handling task driven transactions.

If a GPE interrupt is received at the same time ec_poll() is running,
the advance_transaction() clears the GPE flag and the interrupt is not
serviced as acpi_ev_detect_gpe() relies on the GPE flag to call the
handler. As a result, `sci_not' is increased.

Signed-off-by: Jeremy Compostella <jeremy.compostella@intel.com>
---
 drivers/acpi/ec.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 928899ab9502..8569f55e55b6 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -662,21 +662,6 @@ static void advance_transaction(struct acpi_ec *ec, bool interrupt)
 
 	ec_dbg_stm("%s (%d)", interrupt ? "IRQ" : "TASK", smp_processor_id());
 
-	/*
-	 * Clear GPE_STS upfront to allow subsequent hardware GPE_STS 0->1
-	 * changes to always trigger a GPE interrupt.
-	 *
-	 * GPE STS is a W1C register, which means:
-	 *
-	 * 1. Software can clear it without worrying about clearing the other
-	 *    GPEs' STS bits when the hardware sets them in parallel.
-	 *
-	 * 2. As long as software can ensure only clearing it when it is set,
-	 *    hardware won't set it in parallel.
-	 */
-	if (ec->gpe >= 0 && acpi_ec_gpe_status_set(ec))
-		acpi_clear_gpe(NULL, ec->gpe);
-
 	status = acpi_ec_read_status(ec);
 
 	/*
@@ -1287,6 +1272,22 @@ static void acpi_ec_handle_interrupt(struct acpi_ec *ec)
 	unsigned long flags;
 
 	spin_lock_irqsave(&ec->lock, flags);
+
+	/*
+	 * Clear GPE_STS upfront to allow subsequent hardware GPE_STS 0->1
+	 * changes to always trigger a GPE interrupt.
+	 *
+	 * GPE STS is a W1C register, which means:
+	 *
+	 * 1. Software can clear it without worrying about clearing the other
+	 *    GPEs' STS bits when the hardware sets them in parallel.
+	 *
+	 * 2. As long as software can ensure only clearing it when it is set,
+	 *    hardware won't set it in parallel.
+	 */
+	if (ec->gpe >= 0 && acpi_ec_gpe_status_set(ec))
+		acpi_clear_gpe(NULL, ec->gpe);
+
 	advance_transaction(ec, true);
 	spin_unlock_irqrestore(&ec->lock, flags);
 }
-- 
2.40.1


--=-=-=
Content-Type: text/plain


>> > Signed-off-by: Jeremy Compostella <jeremy.compostella@intel.com>
>> > ---
>> >  drivers/acpi/ec.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
>> > index 928899ab9502..42af09732238 100644
>> > --- a/drivers/acpi/ec.c
>> > +++ b/drivers/acpi/ec.c
>> > @@ -674,7 +674,7 @@ static void advance_transaction(struct acpi_ec *ec, bool interrupt)
>> >          * 2. As long as software can ensure only clearing it when it is set,
>> >          *    hardware won't set it in parallel.
>> >          */
>> > -       if (ec->gpe >= 0 && acpi_ec_gpe_status_set(ec))
>> > +       if (interrupt && ec->gpe >= 0 && acpi_ec_gpe_status_set(ec))
>> >                 acpi_clear_gpe(NULL, ec->gpe);
>> >
>> >         status = acpi_ec_read_status(ec);
>> > --

--=-=-=--
