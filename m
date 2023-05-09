Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0006FC952
	for <lists+linux-acpi@lfdr.de>; Tue,  9 May 2023 16:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbjEIOmx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 May 2023 10:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235544AbjEIOmw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 May 2023 10:42:52 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4841DA
        for <linux-acpi@vger.kernel.org>; Tue,  9 May 2023 07:42:51 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-61b5a653df7so54799116d6.0
        for <linux-acpi@vger.kernel.org>; Tue, 09 May 2023 07:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683643371; x=1686235371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiOW2IbiTnp5VUSzgtttG9ELjcxKpmKFEeP7pBI9MOs=;
        b=NEwRvqd6e/mazuLobuBSDRkGwDHDW56VNTtyFoZihKyEZT/gTQ80QFjfdhr9fnGKDO
         lLqgfn07ffushcYt4WuWoClHQm3Bg3IqNNIttSKRomvAxOQLnTfqARLHSOmYnZLQT99k
         PKuCmbDbqhmtKO47xNzV+zocQqiHmeJUdfrwBe7UxYVIT96oNeJ28lZqpwyutQU3bxvi
         /Fb2dNG7oAP3nGo9TTtBTqx5PuyJ0ZjAxUIs/Os610IyO1J8rQ+rgh+cLd11AMAWKMZt
         kWR03rCgkOLrm7DGFvpK4+etEYSvFtuSox8PVWesFrJgJe0gli4jTFtKDBFVwyUzcVZe
         Ww3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683643371; x=1686235371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oiOW2IbiTnp5VUSzgtttG9ELjcxKpmKFEeP7pBI9MOs=;
        b=Tpz7DxdlKKdPsditaTTy+9tTccgVsoeewwOs8mdn1MtSYF9jZUyrfsmzoUK7B0NJou
         sS7q4zZBGRXLzRNYfljv0j0IIX6+XStIzCjdX1QOCJ0P/iUu2W2vgTJlU5S7m5eVghJn
         5kszD8Rrh/3y2euqKxVLBWIRZJCMoBLPRplEKw7rLzejc+pi7LqOpknlWPrA49KIFdKs
         iRIbR8pdxLZx0JfoEXQsogch0G4RUBJqc9KRUgJUfGKBDgO23K4LusrHQZb2J1JHV+TO
         OcwWu3ZMNfyjUdfXmJCtDFX8Wr8g0NGbFAENZh0qh/tdK8ZZQmPCGKPx3x/2MWJcQT3J
         dysA==
X-Gm-Message-State: AC+VfDwZDX8yQ6+yIKMZqluadN1DkXQazEbUs7vi4elwdl7f1TWzIUz1
        GjICiMcoXKuOVZqaHWq0QPWk1mJFRfB88/dZKbA=
X-Google-Smtp-Source: ACHHUZ7tCM6IgROl/67GJQX+KxJAINWOi2T96GRS2+9UlS2/iMydWO2Ed9qYGR04QVgurkxo6RA/8NSMKZMV6ADMVa8=
X-Received: by 2002:a05:6214:2a87:b0:621:3b88:7af2 with SMTP id
 jr7-20020a0562142a8700b006213b887af2mr2302612qvb.52.1683643370228; Tue, 09
 May 2023 07:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230509115226.287318-1-hdegoede@redhat.com> <20230509123542.rbtjp64urvwl5ioh@pengutronix.de>
In-Reply-To: <20230509123542.rbtjp64urvwl5ioh@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 May 2023 17:42:13 +0300
Message-ID: <CAHp75VfrNQz5v4bhfuNeLHZ-ngdL4bZfqVwM0N983VYcHZ5JxA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: LPSS: Add pwm_lookup_table entry for second PWM on
 CHT/BSW devices
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 9, 2023 at 3:35=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Tue, May 09, 2023 at 01:52:26PM +0200, Hans de Goede wrote:
> > BSW PWM2 is used for backlight control for fixed (etched into the glass=
)
> > touch controls on some models.
> >
> > Add an entry for the second PWM controller to bsw_pwm_lookup,
> > so that drivers can use pwm_get() to get a referene to it.
> >
> > These touch-controls have specialized drivers which bind to different
> > devices on different models, so the consumer-device-name in the lookup
> > table entry is set to NULL, so that only con-id matching is used.
> >
> > The con-id is set to "pwm_soc_lpss_2" which describes the PWM controlle=
r
> > rather then the usual approach of describing its function.
> > The specialized (model specific) drivers which need access to the PWM
> > controller know they need the "pwm_soc_lpss_2" con-id.
> >
> > Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> I don't understand the conditional before the call to pwm_add_table, but
> I guess that's ok.

There is a comment.
The _UID can be different for the _HID (so on some devices we have the
same _HID, but different _UIDs, i.e. '80862288 / 1', '80862288 / n'),
this is to prevent duplication for those, on the other hand the
devices where there are two different IDs, i.e. '80862288 / 1',
'80862289 / n', we expect to have the second one only when the first
one is present. At the same time we have no callback for the second
one at all. I.o.w. for the '80862289' we add the table when '80862288
/ 1' is enumerated.


--=20
With Best Regards,
Andy Shevchenko
