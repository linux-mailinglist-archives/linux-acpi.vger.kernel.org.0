Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFFC399598
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jun 2021 23:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhFBVte (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Jun 2021 17:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhFBVte (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2021 17:49:34 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E45EC06174A
        for <linux-acpi@vger.kernel.org>; Wed,  2 Jun 2021 14:47:39 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id q25so3271202pfh.7
        for <linux-acpi@vger.kernel.org>; Wed, 02 Jun 2021 14:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sc77jpDXsQiAn3sguIpNqwoP6hsPQcr6arGUYdonRno=;
        b=H2KwaifQBmnFtPqfUo9Dwgzc3FNJcWSyPBG2nVJt062btlYqXPud7kSdZh9Qv7ayMl
         daWPhsQ1vBf/bJ4LQU7gt/CiPvvmeq0nqrsFGyILfKqGRv5BZGlcrMRlegx7qMXfy9j5
         ELa8tC4i5imzHRcXofCnluT8CIGxnwII0Yr3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sc77jpDXsQiAn3sguIpNqwoP6hsPQcr6arGUYdonRno=;
        b=Ib7gg9l/uVLGZ4sYjc5axztkgW2K0fwvAbsQNL4NxzzYNVw0vnCobF0yZEoCnjGmFO
         8igOo9ULoY8B3haDIyqqKRRQkmog5o1LHpc3WG9DwvYJ1UjS+Jk3we3Afj0an2GtdfPd
         2/A8BVLHf3Ln6xs4Edk6KzIEyQZeS06lRk4C79TCG4aIleJ9J+q+h5mAXY5oRY7FD/Pe
         YIaBgb8sOoLg00ll0lPdxEh3RVi+jftT/jK5+xt50ucOWunf/TqKjaEd1SWT4ZxYexNq
         qSdZ62km7m53UFSlRBx9ailSmGHYyNgyVMFAZtacVlRhQENsUiV7buIJQGKcS1Zutmmt
         8yXg==
X-Gm-Message-State: AOAM532odyuRpTJQUbL3Kp/H3JueiH8WT4IfH3QveO8Zt5BQA+SKQ89b
        lK1y4H4R5eUBTIoaDMHh3JS/Sw==
X-Google-Smtp-Source: ABdhPJxzOXHhrjOcAujs9o8m8h2aiWUQQFlvs9lwd0D8RLskRxkJPKL3Co+6tCY+ACzTLByxzJm0yA==
X-Received: by 2002:a63:e255:: with SMTP id y21mr36265038pgj.26.1622670458713;
        Wed, 02 Jun 2021 14:47:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t12sm354849pjw.57.2021.06.02.14.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 14:47:38 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] acpi/arm64: Mark next_platform_timer as __init
Date:   Wed,  2 Jun 2021 14:46:47 -0700
Message-Id: <20210602214645.695597-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=8a71d42d1cd19e130ba6c8c84211498e729326cb; i=0/cv7PwxsF9pO8ulDkXbeiGiNrvyb0nlgjdks8TBZA8=; m=8a1no1XgXXPojMCn5qL1ghMr3xwNMVdb4aYy73d8ALM=; p=rixUFzpGtN79JA9akXsWQVK6E909sQ67a8z3SAVsgh8=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmC3/EUACgkQiXL039xtwCYN5Q//Rdr yP+tAmU3+tnzP0SizepbwDGu9vhBhSqtQj2Vx6V2/fk1DnPP8OtZBlB1Q9eLOIEMlOLxjbyr9UB+s qO9fP+Pj1Lo4x84QTyH1ssLSsg993BbtnzU+ZEW3FoPWzhDPwpagfxjfAY1s6IkfwYGJ0GEAbqwiC v7uIYK9dLRo7AyfCMRBv+nfw1EOpzS0/aNGqUvMddQuyjst2x5GKt7GGfyWgdsTU0KUeKTUBegE2W V0x1oMKugRbIv+tK9NNmGIpXu49kThJEtSZ7KNKzDs5EiIdzvz6DubieJkHEtYxTCrs/Wy3IbMltn ec1gWgi8amatBRmoC4FhdVuMem2UBDayk92Q1nICJg5b9osOoF7B2zK2X2lNpnzvb2m/e1XhIc7h7 Sqv6UHubxQoDpjdT6Q1MLqlIHQGkmFZe9slm7Pg1FNVdNdZ1ONaTrAxXVBcyxVCDsqk3+In+aRQoP UG/SSvfu6mIszIlDK4r9CnmWBUrItfqpXZWdfsFSk6zbkFzEcdjh7mM86iGlDlw03CPEaHoz1ldFO 0fQ7ydSSgpfjlKvAviSJ1pwOM2Xsv8qYJK1M5mjpW9+8eGcqHI3v5NCjKWTk5COqKRD+NPukPk8i5 mUFi3VHP8RgWqF4j396TD9bqjLWNdac+lapQyjAOFK4Qj/IBVZ30aqHMU4jvAZmY=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fix section mismatch warning:

WARNING: modpost: vmlinux.o(.text.unlikely+0x95ac): Section mismatch in reference from the function next_platform_timer() to the variable .init.data:acpi_gtdt_desc
The function next_platform_timer() references
the variable __initdata acpi_gtdt_desc.
This is often because next_platform_timer lacks a __initdata
annotation or the annotation of acpi_gtdt_desc is wrong.

Suggested-by: Hanjun Guo <guohanjun@huawei.com>
Link: https://lore.kernel.org/linux-acpi/20200508152653.157663-1-wangkefeng.wang@huawei.com/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/acpi/arm64/gtdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index 0a0a982f9c28..c3ad42470a7c 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -36,7 +36,7 @@ struct acpi_gtdt_descriptor {
 
 static struct acpi_gtdt_descriptor acpi_gtdt_desc __initdata;
 
-static inline void *next_platform_timer(void *platform_timer)
+static __init void *next_platform_timer(void *platform_timer)
 {
 	struct acpi_gtdt_header *gh = platform_timer;
 
-- 
2.25.1

