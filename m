Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7CD77FC24
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Aug 2023 18:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjHQQba convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 17 Aug 2023 12:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352072AbjHQQbI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Aug 2023 12:31:08 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889E2E2;
        Thu, 17 Aug 2023 09:31:06 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-56e280cc606so5964eaf.1;
        Thu, 17 Aug 2023 09:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692289866; x=1692894666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eHuxlNkQ41fzp9NxYUnNxWEJyzxxmdJujiZ38s06nE=;
        b=O7k+zjeSy23Q4uOo6nRda/Vn67zFwQyOqTyGqFEAxKkUa0NTcD/bR7MsIDthkssUtg
         QoeEJOIAlNOuQAi7gJRjqSYt/KpKlvHFlBd0YHdLnXHPvwkWIEInxNfPxe7WkS2vjbZp
         Vxwg5QRzRdc56RdCcVgXm9tKz1H/7P37Qxqct37In7xTVa650BHNcbqjYYPxhujjW4Px
         gCjb2t9ieWlseM9mDMMvr2FDZpBrNZkz0UchahH97NCnCyxTelHT1x0EcFikx/Jvo8RC
         1/m90CAXxI5or6UM5M8IRk/BjHN2QknJoDf8VUhz8+/2y4a5FJbXaX3CoWVQ2+Mwqwzj
         Tp8g==
X-Gm-Message-State: AOJu0YxoWdoVsv2Ptqsalo0HhxBXZdACKdaNw9lwG5PVdahPveueRjmB
        Iu/A2M8JDszyZPVRERTq5XVxRdjO6LqU+WpsYE0=
X-Google-Smtp-Source: AGHT+IEQYsPHgL74pnUfu0b6+lkLZQ/2p3fZMDVfBtWKm8xZS/skHl3ZnodUuORtJ2hBqZaii3P2/B/jDyY1ZD+OADc=
X-Received: by 2002:a4a:bb05:0:b0:569:a08a:d9c5 with SMTP id
 f5-20020a4abb05000000b00569a08ad9c5mr327442oop.0.1692289865659; Thu, 17 Aug
 2023 09:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <1690631575-15124-1-git-send-email-wentong.wu@intel.com>
 <1690631575-15124-4-git-send-email-wentong.wu@intel.com> <ZMWIKTAuHqHZ3+dc@kekkonen.localdomain>
In-Reply-To: <ZMWIKTAuHqHZ3+dc@kekkonen.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Aug 2023 18:30:54 +0200
Message-ID: <CAJZ5v0hjZXtkmYnt13E1jizSGu=kkkqYdeS3Y8hc5COUTJtN6w@mail.gmail.com>
Subject: Re: [PATCH v10 3/3] ACPI: delay enumeration of devices with a _DEP
 pointing to IVSC device
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Wentong Wu <wentong.wu@intel.com>
Cc:     hdegoede@redhat.com, djrscally@gmail.com,
        laurent.pinchart@ideasonboard.com, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, bingbu.cao@linux.intel.com,
        zhifeng.wang@intel.com, xiang.ye@intel.com, tian.shu.qiu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Jul 29, 2023 at 11:44 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Sat, Jul 29, 2023 at 07:52:55PM +0800, Wentong Wu wrote:
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index 2743444..59c92a9 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -796,6 +796,9 @@ static const char * const acpi_ignore_dep_ids[] = {
> >  /* List of HIDs for which we honor deps of matching ACPI devs, when checking _DEP lists. */
> >  static const char * const acpi_honor_dep_ids[] = {
> >       "INT3472", /* Camera sensor PMIC / clk and regulator info */
> > +     "INTC1059", /* IVSC (TGL) driver must be loaded to allow i2c access to camera sensors */
> > +     "INTC1095", /* IVSC (ADL) driver must be loaded to allow i2c access to camera sensors */
> > +     "INTC100A", /* IVSC (RPL) driver must be loaded to allow i2c access to camera sensors */
> >       NULL
> >  };
> >
>
> Could this patch be merged via the ACPI tree? There's no direct dependency
> to the two other patches in the set.
>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Applied (under a slightly edited subject) as 6.6 material, thanks!
