Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA632EF5AF
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Jan 2021 17:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbhAHQ0X (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Jan 2021 11:26:23 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50855 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbhAHQ0X (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Jan 2021 11:26:23 -0500
Received: from mail-lf1-f71.google.com ([209.85.167.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kxua4-000425-Tq
        for linux-acpi@vger.kernel.org; Fri, 08 Jan 2021 16:25:41 +0000
Received: by mail-lf1-f71.google.com with SMTP id 202so8798060lfk.5
        for <linux-acpi@vger.kernel.org>; Fri, 08 Jan 2021 08:25:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=4ysF699gum20ke/f8RjKaFSvgbRhAZM2ouyRt7X4Sec=;
        b=AZ0FgybyBCSbkj/TMrKoSeJoyGwFkQq12gqL/E5RU0Hx0AgGBoWWsXf3oYSipMjElk
         l2jX4jPu6pw7OeIjbLKGAV5+oPB2tLPpZrluRRQbnLcS9j2O+y5zb8UGWaMtzQnpIO3a
         FaCoXagLqCe9qfLEPfBk2rMyeuAGxHohHMlRRJaDHQDH/VklFDd9ENlSwD2OYBrbf9kx
         Td1xG/1un1QrZF5D488A7ImIG260V2Td7i6gEez3ow+Gq+FR1hEm+DtnBw5UfF3cfzSh
         Bri2nDRRectpuzzIjkCq3HhoYahDMuqNv9rl3DPrvvxzsbBCQsD09AVwjyho2H1jyuhd
         ZOdg==
X-Gm-Message-State: AOAM53389v294DvAPeHp6XWFcBfThdqelnTaIuwFUFpxOOLjh4XDP6s3
        0msCLj91SynxqQWsNt3EqH8taKQ2NyzutBW0ZbmJxlaaew+W5z4VNj0cexMM5AGg7rhD2UlROpT
        ZQdd04hcn3mlYzFLwmnDZbP+6xJHEh3QV9Z0R8CsrJiv5XpX3ee/4sro=
X-Received: by 2002:a2e:6c0a:: with SMTP id h10mr1936321ljc.149.1610123140356;
        Fri, 08 Jan 2021 08:25:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwKx6HpdNkM3sZ0PdAhD2aJSAg9xbk+QEeabuLyBIv/0NMYrhLvBkVH1TueHAuvhIV8BPYPhzkdpLT7hrF+25Y=
X-Received: by 2002:a2e:6c0a:: with SMTP id h10mr1936310ljc.149.1610123140107;
 Fri, 08 Jan 2021 08:25:40 -0800 (PST)
MIME-Version: 1.0
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Sat, 9 Jan 2021 00:25:28 +0800
Message-ID: <CAAd53p6aURhfFp1RFQxEPtGfzSdUfe4=N=P2rP27ULxp-D4GCg@mail.gmail.com>
Subject: Multiple MODALIAS= in uevent file confuses userspace
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lennart@poettering.net,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Commit 8765c5ba19490 ("ACPI / scan: Rework modalias creation when
"compatible" is present") creates two modaliases for certain ACPI
devices. However userspace (systemd-udevd in this case) assumes uevent
file doesn't have duplicated keys, so two "MODALIAS=" breaks the
assumption.

Based on the assumption, systemd-udevd internally uses hashmap to
store each line of uevent file, so the second modalias always replaces
the first modalias.

My attempt [1] is to add a new key, "MODALIAS1" for the second
modalias. This brings up the question of whether each key in uevent
file is unique. If it's no unique, this may break may userspace.

[1] https://github.com/systemd/systemd/pull/18163

Kai-Heng
