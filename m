Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 607BD107251
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2019 13:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfKVMkr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Nov 2019 07:40:47 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:32993 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfKVMkq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Nov 2019 07:40:46 -0500
Received: by mail-ot1-f65.google.com with SMTP id q23so189681otn.0;
        Fri, 22 Nov 2019 04:40:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=P8+OAUBA/fDF3XT6t24NhhHUdp2lceigt5e2uxicyNc=;
        b=KhIWcH95MxHuZwMN87/m1+t6PV7ZIqIwGX1aOvdpVD8CIcpLdMz3Y162S8F1vsV6Hx
         b2qIkhEeKr167GWcb9bVNuekWoVfvcUTquxSOkJQar9e9taIKqYUhJKx6BxSqyGqjj2z
         sPLpPJlalox8isrCw2kAHjCozrlrads97oBKWVm427LYRtwKXK3sGIDBRiAEXpzuvKrh
         SARLeDpVKZpRaATNOlFOy2W7e6z0XsUlwS+7fQfhxuLo5HLr9JCW2BjF6Qy3YC1zavou
         28Bj/I/xiLaZI7Q6kp3MPnsN0bmuz9/bGb5CqucdC1AODEzW3lLYLy+BNS3DKV0SjyPZ
         7Dbw==
X-Gm-Message-State: APjAAAX5sylPPIbhdgHZqgWKjoNyD57pA2bXrmw/R9Gocb1S971L2AHb
        ZJgczwAFTdUuJmYj25AvS4/luLAIWSlR7xgFo8Y=
X-Google-Smtp-Source: APXvYqym6di3udjt8st7eyLGZZoUbzp+A0FVQPSr14/+QFiHu7iKSsSmW6o1d6uhL2ceToi3JrbgjX4AL4cMhq1p3NA=
X-Received: by 2002:a9d:7d01:: with SMTP id v1mr10045872otn.167.1574426446148;
 Fri, 22 Nov 2019 04:40:46 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Nov 2019 13:40:35 +0100
Message-ID: <CAJZ5v0ioXnbzy86fV7=JfZwjawfN45xXs8-b2xMtnTEy8ACsuw@mail.gmail.com>
Subject: [GIT PULL] Power management regression fix for final v5.4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.4-final

with top-most commit 05ff1ba412fd6bd48d56dd4c0baff626533728cc

 PM: QoS: Invalidate frequency QoS requests after removal

on top of commit af42d3466bdc8f39806b26f593604fdc54140bcb

 Linux 5.4-rc8

to receive a power management regression fix for final 5.4.

This fixes problems with switching cpufreq drivers on some x86 systems
with ACPI (and with changing the operation modes of the intel_pstate
driver on those systems) introduced by recent changes related to the
management of frequency limits in cpufreq.

Thanks!


---------------

Rafael J. Wysocki (1):
      PM: QoS: Invalidate frequency QoS requests after removal

---------------

 kernel/power/qos.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)
