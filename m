Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D04653440
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Dec 2022 17:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiLUQn7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Dec 2022 11:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbiLUQn5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Dec 2022 11:43:57 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C314E1B1C3
        for <linux-acpi@vger.kernel.org>; Wed, 21 Dec 2022 08:43:56 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id kw15so38113643ejc.10
        for <linux-acpi@vger.kernel.org>; Wed, 21 Dec 2022 08:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6ICykQPN4FWYe26rm3myJiY8Og6Xjh6UqIQ4+3pT6M=;
        b=fvqr+Tt94mw0fBiJlvT0zP62QSQdIApdpuPom/2zpbT5xnaDczTj0eM6dkmChablWs
         pG58Sq/Hbdq5LPgWoepJaeyOgySi+Ah7Tf6R547FWMrvA5CUOdCX07YyX6opyZPll0z+
         YmIaZpKWs1u1fhOkfzQwAhrdfRzL5rlVsVrMOa6ngc9J2RtEhsWS89LkMkhE75JmBPDF
         W62n7owzHummK20AwwsSH0clysC0rUOz89nxX4qOCVfS+scGYxaDz3EmGTSuet2Y9Ehg
         zBWfyGFJBqhODk82rM/y3UWamtq3ZtB4iG8cs1omqSuKr5RZeccZocS7GiqClIPIbj9I
         4nog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b6ICykQPN4FWYe26rm3myJiY8Og6Xjh6UqIQ4+3pT6M=;
        b=eUyHwMCaOlkKzrvPnrQ8iKGJ/TX7N0Gk+cgPr9cAh7f0A+LOuFtYKO5mmgYG9soLZz
         Ps+V6cAoYRttvLiKhSTMeoExeD8I25bRXuVzdaPdQUgPmgF/pFwPV15kte23ikvTrR/g
         dJL/dGXfoiwexktrb4eUHgLku48lgKbxIuHUblseUWjt3vGK3rQe7nGiHpSqKydquQ7Z
         Qr7qGqnSGHAX4o2v0PSF2JywsQBtvRospBkMVxsWy2C5DH2kB1dJcAOAHC2txdtbN9m5
         5+Fl7PZIFBKJJzRERQSOe2mLugBFVgUMVWH860didp2z+0dIVcgcKj4U3bixWGt3upo0
         31Rg==
X-Gm-Message-State: AFqh2krlFVw/sR1oM50aGeeGUSXnRMpjiZkws5nAABSjvK2wHIaNjs17
        dVAd7LsUyDKCvrhIRLAfiK/rXoHcBywW2IqXbnU=
X-Google-Smtp-Source: AMrXdXs1Oh0Oq8ZfZ9IOqRvATBJe3v/KKqNbCcYWUOmKdQaiScpLbBttmaRM/rGEVCvTiUMS2PrijtiRuofHLS/Ma+U=
X-Received: by 2002:a17:906:3ec6:b0:7c1:2c5c:c3ca with SMTP id
 d6-20020a1709063ec600b007c12c5cc3camr240074ejj.366.1671641035351; Wed, 21 Dec
 2022 08:43:55 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7208:341:b0:5e:e736:966f with HTTP; Wed, 21 Dec 2022
 08:43:54 -0800 (PST)
Reply-To: canyeu298@gmail.com
From:   Can yeu <rm9831982@gmail.com>
Date:   Wed, 21 Dec 2022 17:43:54 +0100
Message-ID: <CACF1i3jkC6Zso8QFooR1e=bVhX14Cpg9PsrCXrv8i7SkpuzKgQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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
Dear friend,

I have an important message that I want to discuss with you.

Please accept my sincere greetings

Mrs Can Yeu
