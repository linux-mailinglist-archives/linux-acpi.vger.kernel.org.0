Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08E56EB8DC
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Apr 2023 13:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjDVLpI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 22 Apr 2023 07:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDVLpH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 22 Apr 2023 07:45:07 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213381BFF
        for <linux-acpi@vger.kernel.org>; Sat, 22 Apr 2023 04:45:05 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2a8a59daec5so23802421fa.3
        for <linux-acpi@vger.kernel.org>; Sat, 22 Apr 2023 04:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682163903; x=1684755903;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6e2fI4p1pI3so2b6bQ/X7YEL5cKkaSbVraLHj6ERLpk=;
        b=WzEvC7/CEX3B/T0wmhrOsTiWnIfVEghCdmNDNnm7Wg1vhGzHHNtlRZtyjrIgbR04ko
         g/QkaPCxtB30Yj2vdh5u/mK/ZdOrELAELF7HjYkM2V1L3u3AOoY0F59JKyI6FJ+c4HbY
         ZndV+W5eRikTL55oeTC3BRSSg88UTdRqiBdfIjpBdHkWvLhEci34C6/uZiHzLgaJ53F+
         /3ntn0yUnPGNUsy1JGcvqSlZdeXVDxgaQ+/d4/nd8NSq+VCnCIijK23LBrWNMJcIYC3F
         uwdcEiSVB2g8EdD4yDEPvwb+NVxCbKDcb5vRp9hOLaF/a3T72/jEuA4ryVoYyUuUdExK
         P2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682163903; x=1684755903;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6e2fI4p1pI3so2b6bQ/X7YEL5cKkaSbVraLHj6ERLpk=;
        b=bI0SwtmBHeRM/zvBQmngQw9VRqpdFfa2G7sLbGagEmu5ScTh4R1coSEflM+3m50ZUg
         t0/5Gdlz3BBMHsxLonCUGP7a7NVnFx+LThSQZAlzIVYBzLFXQTYxGMyJrjO+E0NBajag
         +OMqePH/Z9Fno8GCtmMWLmBhHK90/5JSIwijoN4IDjfMABfqPWObT/tm58dve3GjCU7b
         sxC+qGIRlKzvsUtC0GGqyfYlmOOoA6O5sQwDHuo57gc3HE80TSOpY0YXS6eN5hfS5umC
         d9S6+JH2vlZbHqTzp0bLEiMfMfaLIy2GvQzT0ItykEuPLbgYQwdW/eDZPOEmkBrE2ph6
         ab7g==
X-Gm-Message-State: AAQBX9f/yTVEuL+PymtGZS3TnoYgsPRLgEnZ6UFDBMLcvS8bMcHVaSlG
        QlJkN/QhnqGKuQnnpvAQBuzK4wX+o4v24SoaUl4=
X-Google-Smtp-Source: AKy350b2rj+PCyu8w3vSrLAKEARlM5xoF2QKqVM480od5ukukEqfD1wajkite2xsEuEJ43Kmj6XEfH/e4vKe2FKprwA=
X-Received: by 2002:a2e:9b93:0:b0:2a8:a5b8:1856 with SMTP id
 z19-20020a2e9b93000000b002a8a5b81856mr1300580lji.10.1682163903323; Sat, 22
 Apr 2023 04:45:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:3431:b0:25b:7e95:d4d1 with HTTP; Sat, 22 Apr 2023
 04:45:02 -0700 (PDT)
Reply-To: wormer.amos@aol.com
From:   wormer Amos <rolsbaraye@gmail.com>
Date:   Sat, 22 Apr 2023 11:45:02 +0000
Message-ID: <CAGkCXQjpWVcbWOCM4isjTRT4xUy1ZZAW+O7+EgMC5AkwwmcFaQ@mail.gmail.com>
Subject: Good Request
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

My good friend. i kindly want to know if you're capable for investment
project in
your country. i
need a serious partnership with good background, kindly reply
me to discuss details immediately. i will appreciate you to contact me
on this email address Thanks and awaiting your quick response,

Wormer,
