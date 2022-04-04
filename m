Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524A94F16A3
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Apr 2022 15:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376684AbiDDOAL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Apr 2022 10:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355704AbiDDOAL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Apr 2022 10:00:11 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC383EBB8
        for <linux-acpi@vger.kernel.org>; Mon,  4 Apr 2022 06:58:15 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id r2so11285909iod.9
        for <linux-acpi@vger.kernel.org>; Mon, 04 Apr 2022 06:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=OzLduqLdlph/C3MBg4rY8qTwRp/ibnBbeg0V9G2gDQo=;
        b=RBo/+MytuYYGRGXioa2gynomK3dazn9Dq04nmULN0T5KopMW5sLL2FxojJk0PqjzVI
         XanqFb0zlwTd+1LaQlAYiQ2XeW/IsG6oD5yaZ4TB1vF4Yg3kLVqXvXJkxGfAS6AfIbT3
         Ua0BpDWcN6oePU9vuYMzZMVS5ADeebwtq5e1Gu8rp4WbpGLNzggAaUg0MD5nWfsqDntb
         zgFM6H+JXkVb7O3YUg49RkWXrWb44mjD89ZELTGSY8QYDfYNLHT+YIjisbJfDWnvQN/Q
         gGTkReqbB+a3x143FenxWGr9k6qwCqtSEVFmwah1u481xSpOV+rqxBe3BNhDVHm3t37F
         2GXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=OzLduqLdlph/C3MBg4rY8qTwRp/ibnBbeg0V9G2gDQo=;
        b=1v2VLyxBdu3U0j3DNopuLq8r5KF/TTHZdRjvmzoGsoiM9gHdeNKJGjifxK2sc3FxFT
         yRm92ICyl48wkmMI6d6h0I/HSx/5VijHbN9WkvCvs51FE3KWMbS6rcfvmeflIUyGc7ez
         d5BLddf+WDj4pHTVqwZUxZdbnwtRGMi9sCnfByWN2FoOPzkrz0NB//Xm/kxgqkgZrZU0
         zQEF9F1fWKU0AcvwdvNEKFbgQa6QiJuIaqanvubmE/pi6Rgh0go5Rs/XM5hcjbiboy+g
         K1GK696Uj/W6fD2coqliPmWTUVt5TqHmHlN41Y1aXusln4c1ywnSs3HS6IhV4O8KgWKO
         +igg==
X-Gm-Message-State: AOAM533zQGxMRS0eLgxD88YXh5mxtjA5T1Mmspx0xt6oS7sHsSbtY0HR
        G4dhv8WPoJYxQL3dL2gpUIZCc0OC7HCv2VUGEXU=
X-Google-Smtp-Source: ABdhPJyTqbjEifgvNiyeW9maFcGb/36L9a4PBk9gp1v1ogxP+jXSsK2/SMhzEGbGnbW0dZbwZuYdCWW/fViTPMCgMJ0=
X-Received: by 2002:a5d:94c2:0:b0:60b:bd34:bb6f with SMTP id
 y2-20020a5d94c2000000b0060bbd34bb6fmr75200ior.32.1649080695240; Mon, 04 Apr
 2022 06:58:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6602:2c8a:0:0:0:0 with HTTP; Mon, 4 Apr 2022 06:58:14
 -0700 (PDT)
From:   serge amidal <amidalserge1@gmail.com>
Date:   Mon, 4 Apr 2022 06:58:14 -0700
Message-ID: <CA+1711h2xnejbm=bXLtPEkG=AUbV05tjBaA1RDY-vTzJzuccsA@mail.gmail.com>
Subject: message
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello
 I need your urgent help to transfer an abandoned fund
to your account within 10-14 days if you are interested, reply to me
with your information for more details. your first and last name: -. Your
the country:-. your phone number. : -.
 Please reply to this email address (sergeamidal@gmail.com)
 Best regards
Amidal Serge
