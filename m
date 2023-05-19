Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C851709EFA
	for <lists+linux-acpi@lfdr.de>; Fri, 19 May 2023 20:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjESSS5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 19 May 2023 14:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjESSSz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 May 2023 14:18:55 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFB1124
        for <linux-acpi@vger.kernel.org>; Fri, 19 May 2023 11:18:54 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-96f72e6925cso18785566b.1
        for <linux-acpi@vger.kernel.org>; Fri, 19 May 2023 11:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684520333; x=1687112333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=so+bo7zdUonvxTMw/6MarNpz0HLQR2Jki5BjzZX+v5o=;
        b=dSHW/hoHIbFkjiIJiFDTUgQLiqiGtirw9CzWlnhQVjiy7r++rwGgFMPrnFOuwpw+1k
         Zl9syPGflJOCTAQoWeBU1UYcDZMZng2UX5xD4uqu4lBgEJySUI0y2ThSz5WH71dMBqkC
         XNgMMCgMi7RJBECko1EeJ+2wYU3ju00BHtnDHh6Svl2dbGChg54V8h8I1HxwRT/pI2xS
         GiWFwW2+ELGO4jyOXgBDW+I5OD3wfgoA045zgPbbayRursNR32DjkLYc3S0KrfQavo0z
         37dv5eyq1Na4bKcWA1/ojbfcBN7jg69ofqnYfjaK5EdQZgBQXW+PGmasrQLS6O0C3N6v
         Qqow==
X-Gm-Message-State: AC+VfDxxhfos6LrfuWuEKN9uVTnv1ZJI/qoYtsWL2A31iIb76Ysf4tZS
        2Q6pXN5teVbNuG1HPEECBm+9Jons5R6intZAd9si3yRb
X-Google-Smtp-Source: ACHHUZ4PT2Bmv7Fom/9BGoBUj6bJT7eUPfqEpRPHtS9Mt0VH+b41ftTaul4n9d5uZJdK2nfmB+4wjbZShiBkvE1Kmt4=
X-Received: by 2002:a17:906:4c:b0:966:1f60:fd32 with SMTP id
 12-20020a170906004c00b009661f60fd32mr3120985ejg.6.1684520332791; Fri, 19 May
 2023 11:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230509124100.288814-1-hdegoede@redhat.com> <20230509170948.GN66750@black.fi.intel.com>
In-Reply-To: <20230509170948.GN66750@black.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 19 May 2023 20:18:41 +0200
Message-ID: <CAJZ5v0hyA=WeKfuerv+TjTH6TFOZj3naypS7enj9R8fTwi+fkQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: LPSS: Add pwm_lookup_table entry for second PWM
 on CHT/BSW devices
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-acpi@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 9, 2023 at 7:10 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Tue, May 09, 2023 at 02:41:00PM +0200, Hans de Goede wrote:
> > BSW PWM2 is used for backlight control for fixed (etched into the glass)
> > touch controls on some models.
> >
> > Add an entry for the second PWM controller to bsw_pwm_lookup,
> > so that drivers can use pwm_get() to get a reference to it.
> >
> > These touch-controls have specialized drivers which bind to different
> > devices on different models, so the consumer-device-name in the lookup
> > table entry is set to NULL, so that only con-id matching is used.
> >
> > The con-id is set to "pwm_soc_lpss_2" which describes the PWM controller
> > rather than the usual approach of describing its function.
> > The specialized (model specific) drivers which need access to the PWM
> > controller know they need the "pwm_soc_lpss_2" con-id.
> >
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied as 6.5 material, thanks!
