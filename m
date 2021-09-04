Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3A6400C29
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Sep 2021 19:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbhIDQnW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 4 Sep 2021 12:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236679AbhIDQnV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Sep 2021 12:43:21 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED88C061575
        for <linux-acpi@vger.kernel.org>; Sat,  4 Sep 2021 09:42:19 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so1676190wml.3
        for <linux-acpi@vger.kernel.org>; Sat, 04 Sep 2021 09:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=dqN1F2p/WXZ9l/TtPTY5XeR8JVq9Pp6QHGdHpy1HE3I=;
        b=f1zivP7BdQJqsJt3aH4+5qamksQVyOu3egGItxzz46L6hSlXjebgdDGf7z90zDm0h4
         J65DZ50yz7AyiuB9F1pKhgFaC66Sh6L0RT2iyoV4D03uiuAJmAz/SCddx4MREVZLxT/8
         ywNjgpd3Uk3n46Hul0IeZGhk8jcyguRWpVdtmmMTaCn4Rglvg6jug6CLp0UbdnxflS0S
         X9bRSYYu5qfWOUiPIrPGsDfFQ7v3Mai2onC02KgCLLzycNcPmpzzMo9lx5xRIy3YfFgo
         RbBhopWwI8qamJkg9dNiqttg5SUzsPCGfgkRaAYxn8eRpbJ5gKQYICGySHu5SVEbEvfe
         +9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=dqN1F2p/WXZ9l/TtPTY5XeR8JVq9Pp6QHGdHpy1HE3I=;
        b=b6X0cAb1CgYwHdnkBICWuwfYGSwTZQEjYJEHNdFAsDBLtrDdRLM+/3A6O/hIgs1X+X
         qfoBi1nd6cD2EOk4cWVM1crB7blMxW+grnNe4auIoGejXO3X2Xc5/iPo8L7fJJ2sQzYG
         92hqB7hRHyhFN87ombNJ5MCJg1thEUFew7RXT+36Rr1mR4hFJlNv1U2BfSryRC4gLIkN
         BIDmKem4I0QCirWzzOVNYgeckJwVw5WQ1pNFU5CauVCZXs0mTxAxt7bUZen+kYPX8zD7
         Oa25+5itxD3vl1N7XqyCT2WGA9zAL7qh0Sz5MfIrUzP2Xp3M8YKCFmyc71tBCIeo2jsh
         NnzA==
X-Gm-Message-State: AOAM532rE/32rlwsNSdQ3VLaHIRxAHhKU5oetDO1DuCEUx4/3uXgjUk+
        RqN6EJqDu7PXCtYNIRuSFB4=
X-Google-Smtp-Source: ABdhPJy6IHmdnKa8y7tQnGaqR9aFUnn/3xllyUuEYxqMVT32vArhdxrd26LCBENjpStmNLOMd55QlQ==
X-Received: by 2002:a7b:c855:: with SMTP id c21mr3920554wml.0.1630773737370;
        Sat, 04 Sep 2021 09:42:17 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f08:4500:dda1:751:1fe4:17b9? (p200300ea8f084500dda107511fe417b9.dip0.t-ipconnect.de. [2003:ea:8f08:4500:dda1:751:1fe4:17b9])
        by smtp.googlemail.com with ESMTPSA id r20sm2713786wrr.47.2021.09.04.09.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Sep 2021 09:42:17 -0700 (PDT)
To:     Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     linux-acpi@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Question about acpi_remove_address_space_handler() behavior if
 handler is running
Message-ID: <57a2a9fa-e296-85dc-75f8-94ccd0527204@gmail.com>
Date:   Sat, 4 Sep 2021 18:42:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

i801 i2c driver installs an own ACPI io handler. When discussing some driver
improvements one open question is about behavior of
acpi_remove_address_space_handler() if the handler is currently running.
Will the function wait until handler is finished? In other words, the actual
question is: Are we guaranteed that after the call to
acpi_remove_address_space_handler() the handler can't be running?
