Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F32E4F843
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Jun 2019 23:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfFVVEH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 22 Jun 2019 17:04:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38440 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfFVVEH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 22 Jun 2019 17:04:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id d18so9843370wrs.5
        for <linux-acpi@vger.kernel.org>; Sat, 22 Jun 2019 14:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ep7EQzWwrMcUmPEI5lSh6vstSQFA8QVY1yTPNddF16c=;
        b=Svecz0IsOdbg4En3L2WiaVs+tFJGhiAaVSgxR6SMKQ67iO3XKlRPR/pNLJoUVnttKw
         PGKMAwnBDmYS+X8wLQo+UEIm7pu57T7mHJx3U2Fc0z4LeyEUkTmcjM5BmvaNQPeIAi6p
         HOvlbZ6+ok8XxNI1rjPxyyTMKnIsqARh+fcevV0lRzbbVZhYIjtmfzFTKEZdbZvW9iDs
         6FAVguJs5YNkwtYlAVuV1Hyvz7DeOxtYKPx7Idxfk8lNJYPVThJbgGVZARbB2JWM3jkM
         U/Qg1DCH6kzfIv0TaAIc74OgcmXZdX6CeQ5nztEcFDVOmaELGrAQaeRNXjiNjuwP9FPz
         j7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ep7EQzWwrMcUmPEI5lSh6vstSQFA8QVY1yTPNddF16c=;
        b=JyNeYxCtBZHNEG8h9vPr2Y8jakYCtuhdkTiOwU2qiTkdwMGC9ZiFa8agQPEItzbapm
         rzHPm1X+iU0DTQn/Uq/Zuy3S7pBHA8f0xB9ljHadM6x0yXBifm62QvRIHc9l4tDfs+Cj
         jIfWTX55nyxRuyQ5kA1McTHaQpn0m/+IroGR3rnufcLZxWhrwvp1/yhLsp8UVVrLwJDk
         lbcDBGpAJYRZCPNZPm+m5k5QGHYt/LY7a32oV3r0YoJoCXN+lBZU8Nmp3N04Jvhx+GhG
         wSkvDrekFQX6Z86fP+bfNvZnNSzO1JTjSEYM5QxIbVeLdHHbxSaB2lmXa2uJrGSDJwhr
         mE6w==
X-Gm-Message-State: APjAAAXdtTH7v7zC/52MDjWvzZ2SybOEpFc0PG1matNeE8UdrrfifmHV
        FKXYUrhYMUfUKemZjntKfxW0RQYccIIfc1vXtCo=
X-Google-Smtp-Source: APXvYqyY9kKSLpcy6iRkT6NtadiVDfjRY1yEjgRvsadC+Q/7zZw22je6t4wYBBXmd8jca80n7yKmjnhVW/xMYZRkED0=
X-Received: by 2002:a05:6000:11c2:: with SMTP id i2mr2336868wrx.199.1561237445501;
 Sat, 22 Jun 2019 14:04:05 -0700 (PDT)
MIME-Version: 1.0
From:   "Laster K." <officiallazerl0rd@gmail.com>
Date:   Sat, 22 Jun 2019 22:03:54 +0100
Message-ID: <CAMhj-NcA8J8rD1PC6mH+HAjBdv2H532UB5aB5-0Y6VWtUh=8-g@mail.gmail.com>
Subject: [PATCH] ACPICA: Fix compilation with bare-metal toolchian
To:     robert.moore@intel.com, erik.schmauss@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

An ifdef expects to be compiled with full-fledged Linux toolchain,
but it's common to compile kernel with just bare-metal toolchain
which doesn't define __linux__. So, also add __KERNEL__ check.

Signed-off-by: Laster K. (lazerl0rd) <officiallazerl0rd@gmail.com>
---
Apologies for the multiple/spammed e-mails, I was having mail client issues.

 include/acpi/platform/acenv.h   | 2 +-
 include/acpi/platform/acenvex.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index 35ab3f87cc29..b69319198cb8 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -148,7 +148,7 @@

 #endif

-#if defined(_LINUX) || defined(__linux__)
+#if defined(_LINUX) || defined(__KERNEL__) || defined(__linux__)
 #include <acpi/platform/aclinux.h>

 #elif defined(_APPLE) || defined(__APPLE__)
diff --git a/include/acpi/platform/acenvex.h b/include/acpi/platform/acenvex.h
index 2e36c8344897..c7697a47e33f 100644
--- a/include/acpi/platform/acenvex.h
+++ b/include/acpi/platform/acenvex.h
@@ -19,7 +19,7 @@
  *
  *****************************************************************************/

-#if defined(_LINUX) || defined(__linux__)
+#if defined(_LINUX) || defined(__KERNEL__) || defined(__linux__)
 #include <acpi/platform/aclinuxex.h>

 #elif defined(__DragonFly__)
-- 
2.17.1
