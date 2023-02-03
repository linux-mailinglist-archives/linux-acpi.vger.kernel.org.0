Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3863688F5D
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Feb 2023 07:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjBCGHq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Feb 2023 01:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjBCGHp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Feb 2023 01:07:45 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968B664DBF
        for <linux-acpi@vger.kernel.org>; Thu,  2 Feb 2023 22:07:44 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id s67so2981484pgs.3
        for <linux-acpi@vger.kernel.org>; Thu, 02 Feb 2023 22:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eeDs8HDvvAhEGfhdUR1XjfNZXXjxNqlsBQOOR5XCK4M=;
        b=tVZ6NeDxk/W+lNCZyWJ9IwYjDBeP11WFEJi09dOY6iE4X5Ff2R2dSZpmjhh5VhplrV
         XOGyDkqmLqPQr8ngKfHUJt7LMYdhghQ7HFtwaOiOIqmKuhVv/J6tYf9w0tpUkbL/bZlm
         nTQj1ZPAZ8hXV9IpjEibn9RdgRW0T5j6EHTacs6qYg03B2MagqMzV6hI1fq4x02G3/7b
         T5sDsqwKYnBP+tDz4GkQsP4fJUYEMt1FBuR4sUiJ53/HLlVc9chWMaT0ejd8QRi7gvNS
         b8Z6+8C3wp28xXNkJSAHruP5/0Je6Ox2nE1+IGILfkoGFQwaZMRaLdKXZREcJ4Jpso0I
         3sUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eeDs8HDvvAhEGfhdUR1XjfNZXXjxNqlsBQOOR5XCK4M=;
        b=SRX2gsIIOPpIyuhnM9/RPXctbySkf7pjvO014HOa9aFmydCZMM25nY2VvehmkBHnMB
         GlGwKQGeLHPxaYFDzwPSf+Xbr6c+WgG4pM0blOl7N+9zSJh4emphhXwMUcrv2zvTfvxD
         /k5Rsc+v16kC8FXGBGSWCoXufZu9mNNRSB1T3TthigmDADzH8nqOlHlb5n12UdvNnavu
         KLbwxhqz1PCWiBBYSq79sctutoAWC9WaoHKOVwzg8k9AIC8XJORjXiacE9CQX3FEfyq0
         ORyyCK2WjxBecAU3zFYJjVgy1cCgXMeEC7DH52qf4CtYiJ/AYIeVdHgPy0Jg5W6QBXWs
         QvQA==
X-Gm-Message-State: AO0yUKWhs5K2aVuT62uPgnnCKk6jUugSHQF9iDP8dEyWmQlbows9RnnB
        abNF95PfCaJZn/K8w0JLgrKa1xC/HR7mhBFX0bnGKw==
X-Google-Smtp-Source: AK7set/p/WShA1xHjrVygScWQh0RWoSwu/3Y2FJcA3yi0yR9YqseOEw+tIN5ANw1DiIcVpMTldQPwJ9ijNbmDGlsYNs=
X-Received: by 2002:a62:1a57:0:b0:593:bac2:b49 with SMTP id
 a84-20020a621a57000000b00593bac20b49mr2250496pfa.44.1675404463277; Thu, 02
 Feb 2023 22:07:43 -0800 (PST)
MIME-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com> <20230130085542.38546-1-naresh.kamboju@linaro.org>
 <CAGETcx_411fVxsM-ZMK7j2Bvkmi2TKPbzSuD+03M3cb7WKHfJw@mail.gmail.com>
 <20230131101813.goaoy32qvrowvyyb@bogus> <CALHCpMijXAgQx2qq8g8zdq=6AHwP+g5WVBjjry=v+dKEq9KDLw@mail.gmail.com>
In-Reply-To: <CALHCpMijXAgQx2qq8g8zdq=6AHwP+g5WVBjjry=v+dKEq9KDLw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 2 Feb 2023 22:07:06 -0800
Message-ID: <CAGETcx_UvW819m1Y-QU_ySB1nG_RegKKT06=YjkK=C_qjbAySw@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] fw_devlink improvements
To:     Maxim Kiselev <bigunclemax@gmail.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        abel.vesa@linaro.org, alexander.stein@ew.tq-group.com,
        andriy.shevchenko@linux.intel.com, brgl@bgdev.pl,
        colin.foster@in-advantage.com, cristian.marussi@arm.com,
        devicetree@vger.kernel.org, dianders@chromium.org,
        djrscally@gmail.com, dmitry.baryshkov@linaro.org,
        festevam@gmail.com, fido_max@inbox.ru, frowand.list@gmail.com,
        geert+renesas@glider.be, geert@linux-m68k.org,
        gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        jpb@kernel.org, jstultz@google.com, kernel-team@android.com,
        kernel@pengutronix.de, lenb@kernel.org, linus.walleij@linaro.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux@roeck-us.net, lkft@linaro.org, luca.weiss@fairphone.com,
        magnus.damm@gmail.com, martin.kepplinger@puri.sm, maz@kernel.org,
        miquel.raynal@bootlin.com, rafael@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, sakari.ailus@linux.intel.com,
        shawnguo@kernel.org, tglx@linutronix.de, tony@atomide.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Feb 2, 2023 at 9:36 AM Maxim Kiselev <bigunclemax@gmail.com> wrote:
>
> Hi Saravana,
>
> > Can you try the patch at the end of this email under these
> > configurations and tell me which ones fail vs pass? I don't need logs
>
> I did these tests and here is the results:

Did you hand edit the In-Reply-To: in the header? Because in the
thread you are reply to the wrong email, but the context in your email
seems to be from the right email.

For example, see how your reply isn't under the email you are replying
to in this thread overview:
https://lore.kernel.org/lkml/20230127001141.407071-1-saravanak@google.com/#r

> 1. On top of this series - Not works
> 2. Without this series    - Works
> 3. On top of the series with the fwnode_dev_initialized() deleted - Not works
> 4. Without this series, with the fwnode_dev_initialized() deleted  - Works
>
> So your nvmem/core.c patch helps only when it is applied without the series.
> But despite the fact that this helps to avoid getting stuck at probing
> my ethernet device, there is still regression.
>
> When the ethernet module is loaded it takes a lot of time to drop dependency
> from the nvmem-cell with mac address.
>
> Please look at the kernel logs below.

The kernel logs below really aren't that useful for me in their
current state. See more below.

---8<---- <snip> --->8----

> P.S. Your nvmem patch definitely helps to avoid a device probe stuck
> but look like it is not best way to solve a problem which we discussed
> in the MTD thread.
>
> P.P.S. Also I don't know why your nvmem-cell patch doesn't help when it was
> applied on top of this series. Maybe I missed something.

Yeah, I'm not too sure if the test was done correctly. You also didn't
answer my question about the dts from my earlier email.
https://lore.kernel.org/lkml/CAGETcx8FpmbaRm2CCwqt3BRBpgbogwP5gNB+iA5OEtuxWVTNLA@mail.gmail.com/#t

So, can you please retest config 1 with all pr_debug and dev_dbg in
drivers/core/base.c changed to the _info variants? And then share the
kernel log from the beginning of boot? Maybe attach it to the email so
it doesn't get word wrapped by your email client. And please point me
to the .dts that corresponds to your board. Without that, I can't
debug much.

Thanks,
Saravana
