Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0979F3A2CEE
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jun 2021 15:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhFJN2E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Jun 2021 09:28:04 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:37497 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhFJN2D (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jun 2021 09:28:03 -0400
Received: by mail-ot1-f52.google.com with SMTP id 102-20020a9d0eef0000b02903fccc5b733fso4467368otj.4
        for <linux-acpi@vger.kernel.org>; Thu, 10 Jun 2021 06:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UYLLvIPdE1o/76MbzTifD7wCh4SHoiMTnhxgN/DYxHY=;
        b=OapmxcEg6iIgLpPkW4qWQ5y8g4VaxGIq9nYro86C42T0uF/FTHrWSjYJcp7/klJZTt
         A6B37Ogr22iHc6o/qqOY8VvLvy/Pa+Q4/cI8LIQdxNs5V+9mtsnaGNfokrTkiIEf5lpA
         iI1AItfuGN8PqRTpoR1T5AOV2pfICRtjExsRhdR9XTH2Rz1rFD/QPPBDKWCXAYAaq26L
         HaBaG/nnhzXXsRdK1M1AD1mGNNKsqzDgGAZ2vXYR76Q3Vvlf9DRDFdW/4b+Ya2nXrvxI
         DIKQZI7YoS0AO+SqU2OWTm96w/hMIPkKaYj30de6qj2R7/oIoIxAc0DTRAU/NVEjVjOo
         Zgvw==
X-Gm-Message-State: AOAM533gCLHdgY9a7lMVu/IHeXNDtBnliET0B3MMxyQQqTYJ833G99Kl
        1KRZu5ze/XgO6prJkYjC20MbXKp659BTrfwLoLs=
X-Google-Smtp-Source: ABdhPJz8dOZ24lkxjAMc/Ce4MEPGtGLCrotX98UC4s52IhKihJgXwSQX61y+k1bRNRQreE7Ykzqa5JLFmhiXlj1wIso=
X-Received: by 2002:a9d:3e53:: with SMTP id h19mr2468455otg.260.1623331567160;
 Thu, 10 Jun 2021 06:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210609175130.224274-1-hdegoede@redhat.com> <YMG4vrHB6SwD0/uP@lahna.fi.intel.com>
In-Reply-To: <YMG4vrHB6SwD0/uP@lahna.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Jun 2021 15:25:56 +0200
Message-ID: <CAJZ5v0gt6u8kx+zApvLexvurK=kEOO-ujJMSs06PcvZ=75LFjg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Remove redundant clearing of context->ret.pointer
 from acpi_run_osc()
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 10, 2021 at 9:01 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Wed, Jun 09, 2021 at 07:51:30PM +0200, Hans de Goede wrote:
> > context->ret.pointer already gets set to NULL at the beginning of
> > acpi_run_osc() and it only gets assigned a new value in the success
> > path near the end of acpi_run_osc(), so the clearing of
> > context->ret.pointer (when status != AE_OK) at the end of
> > acpi_run_osc() is redundant since it will always already be NULL when
> > status != AE_OK.
> >
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied as 5.14 material, thanks!
