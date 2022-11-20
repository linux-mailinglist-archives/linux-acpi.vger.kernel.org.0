Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC3B631432
	for <lists+linux-acpi@lfdr.de>; Sun, 20 Nov 2022 13:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiKTMuh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 20 Nov 2022 07:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKTMug (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 20 Nov 2022 07:50:36 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9792DDB
        for <linux-acpi@vger.kernel.org>; Sun, 20 Nov 2022 04:50:35 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id d3so11887163ljl.1
        for <linux-acpi@vger.kernel.org>; Sun, 20 Nov 2022 04:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfTPu38wdLYx20XCd4g5K+axDKOy6yjpiiCEdHmHiM8=;
        b=arWPZ02tFVcaiqwVL6eAlLYJBWO1O/6qCOQr/RSin9dI9zCt+QtcbD7nyV//FLE08i
         AkzpsAKRsLnE4zFil39IWNiWyoCW08ZpHnRELV+wzqkHJYk77PcqQUrRinTqtQq31F66
         8rmz0V+vHS9bjKSKRBbHmDEvBg2Z59wF9EiO57coU4KQHEZs71cHj+ibAey0YtHUbxiH
         nLTJ1CqBSTJAuf3rs/R/gKtO2iIRjkhvNAW3N52Jj2yTnHTy6E3wap6Mei8nbG7gFxad
         cqQw/Q2LCAlvhO3WIvDPPuEqv4pEmPRluRqJqDfR1AVkfJpseoCzoaUx8uk7rQigfFuN
         o/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pfTPu38wdLYx20XCd4g5K+axDKOy6yjpiiCEdHmHiM8=;
        b=wAc6jGHEbfZMoKk0rxlORL2ANxw8hT6AcGafcBIUbEgOrLfk8J4PB81K+q8YRaNPWw
         xsXN8upyOPYhcMCYuNHqm6v2LLLTjV0N0J3t/Hc+FAhtix9al+TeqnT/xbObfEUyu+1n
         oVCWU5kPc8mWetAEI7QU61NxsLvQ/3WM1DSRP2GRjE7kT7mFEHWP4QvszosHUm3wSlUV
         prfa10S+XncSMeKcaVIxOZaRynHr+MiHCJUFjJ0t6otFlzOmnEUSJczXe8fc8mjqFh6E
         1MtAaa+Z08boWrzIVcXdOSDPQOpLpxDUfvni25gH9wfrlFOUXixGoffY1uwGvhJp+89I
         m9Lg==
X-Gm-Message-State: ANoB5pm3mqowxO0icmT7vMih4oexgY+FfZk5XoNpK6qlUrumt20RMfOa
        hzr8f1L8mCFPzkkXryQrUUc55cTLZEnIxDiO9aU=
X-Google-Smtp-Source: AA0mqf6zlTV9SphwuJNvAd8NnebDS49C9W3FIS51Ojrbnm+4P2xtRSYKw1rPiD7RnUj7TE2/XMDBF08zow3JiCzD8Ko=
X-Received: by 2002:a05:651c:10a2:b0:279:e41:1481 with SMTP id
 k2-20020a05651c10a200b002790e411481mr4346840ljn.184.1668948634040; Sun, 20
 Nov 2022 04:50:34 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6504:4083:b0:200:c202:6a27 with HTTP; Sun, 20 Nov 2022
 04:50:33 -0800 (PST)
Reply-To: te463602@gmail.com
From:   Nam Woo <nwoo4504@gmail.com>
Date:   Sun, 20 Nov 2022 04:50:33 -0800
Message-ID: <CAKEwtxKoBecKZj+Ty_yadqon0mU2a18FA3mJEe7CCuYBcCh5dQ@mail.gmail.com>
Subject: Very Urgent,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

-- 
Hello,,
We are privileged and delighted to reach you via email" And we are
urgently waiting to hear from you. and again your number is not
connecting.

Thanks,
Nam Woo
