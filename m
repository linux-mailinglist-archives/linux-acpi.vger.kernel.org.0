Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B134D6792EA
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jan 2023 09:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjAXIVS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Jan 2023 03:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjAXIVR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jan 2023 03:21:17 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154F4BB;
        Tue, 24 Jan 2023 00:21:17 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id b24-20020a17090a551800b0022beefa7a23so1000799pji.5;
        Tue, 24 Jan 2023 00:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h+nUdlVRMMLsFTpU/kazzWhI51zfhUNvdN+/wzccDJk=;
        b=GxigOLV3NAteE3I/r73cli0IqINT0GKcp7i7bGchPkBTcheNnbHkgkx4U92pAu21r7
         zxtM45qk+Td5AF+QoK2/LJi3lfOY7gwhrI+5+AewqHDd1FAvT1ZbjhI6b9ZYKBdcWswl
         l2zeIYuSX1xi2OHKu2QS5fuuy0mje9fXz/lS8COD1cHp3PPLnoHBLbQhgUmlEWxMFNDj
         v2BueIAu6VRNZtR1uzXMOhnO6yMmV/T0H3PIz3ioRspmb5KOvhF1wTvC8irvvZ/Jxk8B
         dF+8Oy4aMxpKuAngU/0mg499DZGA5lKZ3PTA9sewFr9NYqLCybsW0yzFnAd9+jZxJNY2
         +eSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+nUdlVRMMLsFTpU/kazzWhI51zfhUNvdN+/wzccDJk=;
        b=SiNgwo/cRBEvzoJyJ6mM9uf/h/44Z1gPZQ/6kakIVA99mpXxd5xIWm3arP8wIO4jgR
         NrIR0iqb5triZBkzhIdhMHRfLGXWco/PJx1qVBHmXiViV6WS3hpRPqoYKaZ3JU28o9mK
         07PtReIwYthXATrlGsTgE6YzZphP3pKLVMv7008N4mA9DMFyc9eNnlPppa84rtUSsv0q
         V8bAU2rK0LIWibsWyPBMp5sGxgb7amIKCbxcwDEZYPKu83W7JkBUvVp1lbgKLvt5hxU3
         VFvTLsyo2/vMIGFF8qzApJjzn0z1MMUbm4ZNWSBK5MTQhUROlbHAvWAITDh7+UXOGngH
         U6Qg==
X-Gm-Message-State: AFqh2kp4H1Lp7xq8UflTMCbkDZ8P6tsqwJwEyHo9ivQ1UcpdfDCu7VRQ
        ntNrIZHQpYvqvYQ4ZYhw0+c=
X-Google-Smtp-Source: AMrXdXseasp7rsKJLpTckwuIAGUsUEmMMmaQxXLjjJJQ7oh85GKFZkAOMbqH065ffZjuPAyubF+yMw==
X-Received: by 2002:a17:90a:d393:b0:229:60cf:85d5 with SMTP id q19-20020a17090ad39300b0022960cf85d5mr28433098pju.13.1674548476591;
        Tue, 24 Jan 2023 00:21:16 -0800 (PST)
Received: from redecorated-mbp ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id k190-20020a636fc7000000b00478c48cf73csm828305pgc.82.2023.01.24.00.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 00:21:16 -0800 (PST)
Date:   Tue, 24 Jan 2023 19:21:03 +1100
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     gargaditya08@live.com
Cc:     andy@infradead.org, hdegoede@redhat.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, lukas@wunner.de,
        mgross@linux.intel.com, platform-driver-x86@vger.kernel.org,
        rafael@kernel.org
Subject: Re: [PATCH 0/3] ACPI: video/apple-gmux: Improve apple-gmux
 backlight detection
Message-ID: <20230124192103.71673c69@redecorated-mbp>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
In-Reply-To: <4E707490-819D-448A-904F-CD8028894CE2@live.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> > Aditya, can you perhaps test this on a model macbook which does
> > actually use the apple-gmux driver for backlight control
> > (assuming you have such a model) ?
> >=20
>
> Hi Hans
>
> Since I own a T2 MacBook, I=E2=80=99ll have to apply some out of tree pat=
ches as well
> from https://github.com/Redecorating/linux/commits/bits/010 gmux. I=E2=80=
=99ve
> requested the maintainer although he believes they shouldn't break anythi=
ng on
> T2 Macs. I=E2=80=99ve still let a kernel compile without the out of tree =
patches, just
> with yours and shall send the outputs by tomorrow.

I'm the one that wrote those patches for gmux on the mmio T2 macs, and
I've rebased them onto Hans' patchset with patch numbers 2004-2006 here
https://github.com/t2linux/linux-t2-patches/tree/gmux

It seems to work fine on my T2 Macbookpro16,1, the display backlight
controls work and there aren't any other, not working, backlights
present.

> ls /sys/class/backlight
gmux_backlight@
