Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566AD76F332
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Aug 2023 21:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjHCTD4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Aug 2023 15:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjHCTDe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Aug 2023 15:03:34 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F56D49EC
        for <linux-acpi@vger.kernel.org>; Thu,  3 Aug 2023 12:02:58 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-56c7eb17945so800872eaf.2
        for <linux-acpi@vger.kernel.org>; Thu, 03 Aug 2023 12:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691089369; x=1691694169;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BXRGuT4L4X+oTs7GXIYcKWLxlE2JhDJKiOKZhG15lII=;
        b=h1FZRxKRrypv9CcK6L0QAcnGr/F9OMt4LGQhiW3Yi+ZRURdne/aauBdn5IyfbeOUzl
         CjHdV0KIX0R/36gH4PVt4ueCi1+OInAAWBw3MOHGOl9Zh3l1b5p4eWf7VqS4BkbKNcnc
         OGJJq/IwKDcU7WhUvdaGDsGhWScEateBzdItaKqdxC6eQoUHAvT5f0Wuu/ZeUQ4fGUYh
         +S7DXOhZhSmyTCQ/LipPC4jDYwWdEXQ9cKNeo3cch7n6IF5oFJF5zuF7LkFYtTNDNH8z
         rBPDORkHRULTX3EodXXSQYumH3OQ7DWSCmZKg6uHUsaEC3ztIEjuRnUe/v5KDAuDYNOY
         OVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691089369; x=1691694169;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BXRGuT4L4X+oTs7GXIYcKWLxlE2JhDJKiOKZhG15lII=;
        b=TlMl/oiCQ25B7hoaXVuj2kaF05KXxm5O4i8CMoohmL5E+Sq/hMw889SVdEIJLG5Pwo
         +v+AfEQlhdxvf8oVf0Cd4SLMD1DWVkALs2Z3dORbbY1C5Y/pwM2gONhXPIR55QTJxnZf
         QavUx215PDqtnL5dLbpymlbSySVN3MhFupE297QFXmcklEQN9tC5KE8cyDxyi0laooij
         rXWVc/ROKpOCmf6i9bja1nAC/UZVtyuYbLbXl3nL8fVkQbhb16XrrxU4D6C4C+x5Flu8
         CTw3Sl9K3bV5aTp40s635mHNUZSOchdhHRD4a+3P0M08NsIOei2HdJtIvBHm4sP4jgMS
         uPGg==
X-Gm-Message-State: ABy/qLY6OcJ/VDGbmXFnqc6NioJhLTXvdLM0Jb44RnaLbIb3D2+IPoyP
        w5Dtl5sxeVCfl/U6EEVW/MevH+Ud01B1Z/lZksvZFF5bx9Q=
X-Google-Smtp-Source: APBJJlE5dapLQ2KEtZ6Hg/CGCoWJeN+4rNx5htYM9KNzarBTyK25Tp3MSK90jNFK02+bjQ3X3BzZXO0K9NaJRDq2HuU=
X-Received: by 2002:a4a:854f:0:b0:56c:cefc:55d with SMTP id
 l15-20020a4a854f000000b0056ccefc055dmr10716785ooh.4.1691089369173; Thu, 03
 Aug 2023 12:02:49 -0700 (PDT)
MIME-Version: 1.0
From:   Neal Sidhwaney <nealsid@gmail.com>
Date:   Thu, 3 Aug 2023 15:02:12 -0400
Message-ID: <CAJ4cxaQAxgnhHavgMLdR8u0VAm4now8z=3sMvTiXCkNOx=+iZQ@mail.gmail.com>
Subject: ACPI & PCI suspend/wake errors on MacBook Pro 14,1
To:     linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

I'm running Arch Linux with kernel 6.5-rc3 (although this behavior has
been since I installed Linux starting with kernel 6.3 a few months
ago, and I don't think it's a regression) on my Macbook Pro 14,1 and
am running into issues with suspend/resume.  In particular, my network
card (BCM 4350) sometimes does not operate correctly after resume, or
also sometimes after a warm reboot, and I have also noticed errors &
stack traces related to Thunderbolt in dmesg output (I do not have any
external peripherals so I don't use Thunderbolt devices at all).
Since it's power management related, and there are a bunch of ACPI
error messages at bootup (in dmesg), I figured ACPI might be a good
place to start if it's causing both problems, and was hoping some
debugging tips could be suggested.

I have gists of dmesg after "boot, suspend, resume", as well as lspci
-vvv before suspend and after suspend (however, unfortunately, the
issue with my network card did not reproduce, but it fails here:
https://github.com/torvalds/linux/blob/4b954598a47ba07034aab9af8ddd485bdc3d5b16/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c#L985)
here: https://gist.github.com/nealsid/bcaeb2d346128b6b2034944612c23dbc.

Thank you,

Neal
