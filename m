Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A500E5A179F
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Aug 2022 19:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241554AbiHYREF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Aug 2022 13:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241532AbiHYREC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Aug 2022 13:04:02 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA98B81E7
        for <linux-acpi@vger.kernel.org>; Thu, 25 Aug 2022 10:04:00 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-33db4e5ab43so75878597b3.4
        for <linux-acpi@vger.kernel.org>; Thu, 25 Aug 2022 10:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+WUTIFUsZBSIaraK+uHwEF6r2m+W1Gnr8fn5pvQXBHw=;
        b=LYCQ4ausMu86kMRfOU5m9m+07DBMfdZSSaiQCu8uX6fudmZ+L6J6IiB23AFUcZvY1k
         MN0olqOlA5QYtpC9F928wmAhrXlvN2EBC8yJhCz/tb9PtWrc4lgYw+rOfbTTUOvB93bQ
         Gm/nbfEgwPe7UbF5eFqW3yBgXHXkIHaL9dixCGsOxwIRaqmT4tJNA2Ux3D9i+DbXdW9P
         oZoIF5MlZoMgkldeAMnxGju3Uxy9qYq+gXLpIRQ6sTVXPLeZDQKKlgRITpuEzNnVG3Vo
         3hESFjyhhCyG6hTQmh46OxZcXX4zVMNn+yaYBKedLdIZjpJqs5GPbLB6dGlmCLfnJTTQ
         rIZQ==
X-Gm-Message-State: ACgBeo3rmSbPUmJ9MBcnJmm9f/dLINxmdbxL8YyHytxmz/kQONQgbzmK
        mJ/I7dXy1f3oPCi9hUCeduQTuETVORTpdAPdkJk=
X-Google-Smtp-Source: AA6agR4WXrz2rWoJ7bHsW2KhV+tsc14ZvbGB3YdS/+BZav1N+wNnGN8JvkvsPibHU02ic6xUkxL/91nMbJyX4VP840E=
X-Received: by 2002:a0d:f647:0:b0:328:317c:9069 with SMTP id
 g68-20020a0df647000000b00328317c9069mr4551461ywf.301.1661447039692; Thu, 25
 Aug 2022 10:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VczhmTTdMbj7z2DOPm+k4SWGzuLF8NyJ2FWHwhfg9HJ1Q@mail.gmail.com>
 <CAJZ5v0j=90uhWRcVWKVyDhEuVNWw-W28RoKkCwxpzNd3NLC9mg@mail.gmail.com> <CAHp75VdfMF_AyONneSMHzmX_cU_tEa97EhL43iu07+9BvFO_ZA@mail.gmail.com>
In-Reply-To: <CAHp75VdfMF_AyONneSMHzmX_cU_tEa97EhL43iu07+9BvFO_ZA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Aug 2022 19:03:48 +0200
Message-ID: <CAJZ5v0g+tBAC87EtOK1E+C-J3k9depNTMGMQ3CmcWnHaCidzXQ@mail.gmail.com>
Subject: Re: ACPI ID list termination
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 25, 2022 at 6:48 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Aug 25, 2022 at 3:48 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Thu, Aug 25, 2022 at 2:38 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > I have stumbled over __acpi_match_device() implementation and noticed
> > > different types of termination of the struct acpi_device_id (ACPI ID
> > > list), i.e. '{ }' vs. '{"", 0}'.
> > >
> > > As I read the code of the above mentioned function, I see that it
> > > dereferences the id field without NULL check. This means we are quite
> > > lucky (somebody before guarantees the match) we have no crash here.
> >
> > I'm not sure what you mean.
> >
> > In __acpi_match_device() id is a pointer used for walking the acpi_ids
> > table (if not NULL).  Its initial value is the acpi_ids value and it's
> > incremented in every step, so it cannot be NULL.
> >
> > The loop is terminated if both the first byte of the device ID field
>
> ^^^ (1)
>
> > and the cls field in the current row are both zeros, so both
> > termination markers in use should work.
> >
> > Or am I missing anything?
>
> Yes. The ID field itself is _dereferenced_ w/o NULL check. So, compare
> two ID lists:
>
> FIRST:
>   { "A", 1 },
>   { "B", 2 },
>   { "", 0}
>
> SECOND:
>   { "A", 1 },
>   { "B", 2 },
>   { }
>
> They are different in the terminator and the above mentioned function
> simply will crash the kernel if no match is found. Of course I might
> miss something, but as I said it seems we are simply lucky that
> somebody else (platform / device core code?) does our job.

OK, I see.  id->id[0] doesn't work if id->id is NULL which it is in
the second case.

I think it doesn't crash in practice, because it's always called when
there's a match.

Anyway, something like this would fix it, wouldn't it:

---
 drivers/acpi/bus.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/acpi/bus.c
===================================================================
--- linux-pm.orig/drivers/acpi/bus.c
+++ linux-pm/drivers/acpi/bus.c
@@ -868,8 +868,8 @@ static bool __acpi_match_device(struct a
     list_for_each_entry(hwid, &device->pnp.ids, list) {
         /* First, check the ACPI/PNP IDs provided by the caller. */
         if (acpi_ids) {
-            for (id = acpi_ids; id->id[0] || id->cls; id++) {
-                if (id->id[0] && !strcmp((char *)id->id, hwid->id))
+            for (id = acpi_ids; (id->id && id->id[0]) || id->cls; id++) {
+                if (id->id && id->id[0] && !strcmp((char *)id->id, hwid->id))
                     goto out_acpi_match;
                 if (id->cls && __acpi_match_device_cls(id, hwid))
                     goto out_acpi_match;
