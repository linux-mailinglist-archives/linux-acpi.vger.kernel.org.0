Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0501CD28E
	for <lists+linux-acpi@lfdr.de>; Mon, 11 May 2020 09:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgEKH3K (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 May 2020 03:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgEKH3K (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 May 2020 03:29:10 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E73C061A0C
        for <linux-acpi@vger.kernel.org>; Mon, 11 May 2020 00:29:10 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id f18so8284395lja.13
        for <linux-acpi@vger.kernel.org>; Mon, 11 May 2020 00:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=KTscfAD0JCHvSYiPLgfsrC0xcobt60NP7Gi96XZWkns=;
        b=QxvBfK1V/7lgzUgttuh/S0xlIp/YIAaaIvmwgdxvXWYTPaRP8TUBb3PIo1gMdALA9k
         Bth382Cc/qAsNmHfNd6tcu4PiIZNpi9QOrlbVmNiFkXDIqWagPQ+/gmAlh5jLH+YB+iV
         xof8RyYY7m630dG074Wsw6CvmPxXGE0dUAKwSRRCTRkNTGsyHLGePUAddj4oAGNOdVh3
         gpRuKpGIQDi40XsxnEe6DvfyVB0HLWYgOkpjmjaVfxf0AL2X1Ehih6ycnjRA8wIFBxnW
         /NZFKFpeRoKMzptciM8HEaZPTUJFbirSVelOtddKfCtrndm0VVJ+g6l+syywf3reW0yf
         Q/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KTscfAD0JCHvSYiPLgfsrC0xcobt60NP7Gi96XZWkns=;
        b=MVkvmqLtYBgjqwhIccdZDOU0MSV1ol2EDmORoq+IHW1PqGHs1i2rLHz2UIm8z3inC9
         6fBakhDUXorkhfaA2j4hgpeDR1J2Q6kQIqDECOpmsbZfuvOe2dS28CC4YgFDvmQlzMvJ
         C92nmZ5E7bu9cMfpdDHOmhPirZEwY8bjRQwsb2RNFIJzpubzh5DkvDgmlUsyvZpMvUd/
         SCyxfbp/AXdaCcbD446HNCW20XmDw+9mtx49urGOXzQNmkKw0DzHbYabkHLTtU7E9sA9
         AxzZdVdPoUcr+nD5qt9gcaqzkBpOfbfXLE+JDlU1Q6oJ7/3JiNH2w4GDmvF1JToXzrWX
         ab0w==
X-Gm-Message-State: AOAM5306Iz0U7rOyreZsRcrt8VKf5Ev2d9Mzlm4qa9Cfa0cDNuF75ANr
        cEY6p09wSRXbm8ymUDwdW/etTAWaz7CvqW6I+/72+5fOIl4=
X-Google-Smtp-Source: ABdhPJwUZdwAGT9Qqy5XyAR/MRXKUH0mVMFo31K4fL9yUyM6TXtqk+jY5/SOklL9DNS9/8uxDkIJh82iZlO8DjGvTlQ=
X-Received: by 2002:a05:651c:287:: with SMTP id b7mr9421048ljo.82.1589182148764;
 Mon, 11 May 2020 00:29:08 -0700 (PDT)
MIME-Version: 1.0
From:   Aaron Chou <zhoubb.aaron@gmail.com>
Date:   Mon, 11 May 2020 15:28:57 +0800
Message-ID: <CAMpQs4LVsD3Crc8nnhY+AXtOyc1nWJ0GBP5DL9co92CBknjZPg@mail.gmail.com>
Subject: [ARM64 ACPI] different CPU L3 cache size reported by /sys/device/ and dmidecode
To:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In the system, I can get the L3 cache size from two or more ways.

Firstly, I can get it from the kernel interface, such as the `lscpu` command.
Also, I can cat the file `/sys/devices/system/cpu/cpu3/cache/index3/size`.

The way above can give me the L3 cache size is 32768K.

Now if I use the `dmidecode -t cache` command, I get the L3 cache size
is 24576K.

And the real size of the L3 cache is 24576K.

Why is it? who can explain it to me?

Thanks.
