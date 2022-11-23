Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71412636945
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Nov 2022 19:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239208AbiKWSuw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Nov 2022 13:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237976AbiKWSut (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Nov 2022 13:50:49 -0500
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABDD8E084
        for <linux-acpi@vger.kernel.org>; Wed, 23 Nov 2022 10:50:48 -0800 (PST)
Received: by mail-qk1-f175.google.com with SMTP id i9so3574148qkl.5
        for <linux-acpi@vger.kernel.org>; Wed, 23 Nov 2022 10:50:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yekgoU1Ol499Q6to0Aks+mbPjL3faacj+2DMpSdx9Hg=;
        b=bqR17FBglE4skyHuT0AoV/gtw9r/8sN46AY+HMBe/UMOWtLhkaXTfJnHRPNLkJpnTe
         2+SjmO0rlI4E0b9O8Swf7Tb0hyVxGkVYV6NmwOpjft9k+lFgjpNLkvuch9ZKF+Q9BOba
         4tnVMly5HizTq8SJpvsCoOsDhNRG2rksjMEHPJpdX8S4Ovn8IB4E7qkN+MsVaHZAWFqb
         HYI5aiOCnlJfCpb/hvPpTTLTDC5/oyNy9dIxNmKxDf80M96PPUVHOtrvcfqYnBkJ2+Fp
         jZYda3iw0eh2u4Ab+DsRKQX7ik3CAyumCl0dXTswLRnlrjpPxLehWqzrMRZ7SY9sCxYc
         XkgA==
X-Gm-Message-State: ANoB5pmUwxWPOe57OtpvkKBrVYkxIJAHiGQjHR7Kr70oixaCYQGeEw4D
        W22eSFPfCGjJvWsE09TPmN2UGXURuaEpASNsJU8=
X-Google-Smtp-Source: AA0mqf4nSSQq5AyesA29fZfr5xubB2vpbm8EBqbu4/EYsXvBGvgJwPRn9NRl0jKTa0CRzyn5yd/jR2hK64Ix2p0wZAE=
X-Received: by 2002:a37:b901:0:b0:6ec:2b04:5099 with SMTP id
 j1-20020a37b901000000b006ec2b045099mr12461248qkf.501.1669229447808; Wed, 23
 Nov 2022 10:50:47 -0800 (PST)
MIME-Version: 1.0
References: <20221122125425.1107474-1-yangyingliang@huawei.com>
In-Reply-To: <20221122125425.1107474-1-yangyingliang@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Nov 2022 19:50:36 +0100
Message-ID: <CAJZ5v0hcsvfoSbYmvNyTZ9KE-4rCL4LLCGHcbeGSVUACroLjOg@mail.gmail.com>
Subject: Re: [PATCH] PNP: fix name memory leak in pnp_register_protocol()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com,
        guohanjun@huawei.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 22, 2022 at 1:57 PM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> After commit 1fa5ae857bb1 ("driver core: get rid of struct device's
> bus_id string array"), the name of device is allocated dynamically,
> it need be freed in error path.
>
> Current all protocols used in pnp_register_protocol() is static, they
> don't have a release function(), so just call kfree_const() to free
> the name.
>
> Fixes: 1fa5ae857bb1 ("driver core: get rid of struct device's bus_id string array")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/pnp/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pnp/core.c b/drivers/pnp/core.c
> index 6a60c5d83383..390e449c17ef 100644
> --- a/drivers/pnp/core.c
> +++ b/drivers/pnp/core.c
> @@ -72,8 +72,10 @@ int pnp_register_protocol(struct pnp_protocol *protocol)
>         mutex_unlock(&pnp_lock);
>
>         ret = device_register(&protocol->dev);
> -       if (ret)
> +       if (ret) {
>                 pnp_remove_protocol(protocol);
> +               kfree_const(protocol->dev.kobj.name);

Having to refer to dev.kobj here doesn't seem right.

Shouldn't this just use dev->init_name and allow the core to sort out
the error case?

> +       }
>
>         return ret;
>  }
> --
