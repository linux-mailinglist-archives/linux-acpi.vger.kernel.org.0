Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010FE3131BB
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Feb 2021 13:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhBHMEW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Feb 2021 07:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbhBHMB5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Feb 2021 07:01:57 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58FEC06178B
        for <linux-acpi@vger.kernel.org>; Mon,  8 Feb 2021 04:01:13 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id u25so21815650lfc.2
        for <linux-acpi@vger.kernel.org>; Mon, 08 Feb 2021 04:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z8kzQS3YPM948wmJnc1Eek6a7lxZy6M65U4pTGtlXO4=;
        b=K16cTG+3k/StGHXC+r8CudIYqXvQ0vkKMMdiq29IfUfaGg5WhQFHyz4MzmcDyypSn0
         dOnPM3izORupsA2vtRW17fDlQ/+X1nMm+/cdwhThC5IIKYEwZdgitpP/GjqX9corVK4F
         kq4X04HsoKT8ridfCeLaIEJta6gMCjRwChzNmFIUPUnTjzQe5LaobNnT4NWqppHgyPsF
         Jgj2NEIaH9mmWF51zRlCqYoS54L26cpuC1I/wL0quD2Vy+gm0AqQCBo8RQb5oUOOLZXb
         Cw82CsWLa/rCox+AwQ0Sg38mab0nI6CxFImAlWUfOTlKxGS1D+ZLNi0/S0VrBICofb5V
         CQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z8kzQS3YPM948wmJnc1Eek6a7lxZy6M65U4pTGtlXO4=;
        b=IBu4C8hyLPYdXnbRbM8xTm0cBlJGVoM7je3F6Xmz9Uen2TzPAwIeoBUOxOGJYnU8XA
         LqzSoKq2U+i37m2foh4Lxjf1AbJOsroPw7Uo3Tj8GaBO7hotAahJYABK444nc/iHJfw+
         ZLovOTKWOQmOCJ4wjm2lN44uXGuPxv8q8V708Hmf3yGCY8FHaHJF+x4q/scHGbfzCf1N
         Z8rm0K/RmDEzdTBHs5vm02xhM5lny7YBsryJDtUCCyRvkx+6dJk8oTya4gYiS9R3ENoE
         I9tKrN4X2zQjFvsYN1DrPtvtCNdMWd1n1N929qXZbePUdFW2tl/CCxKXqeInzRlL6gVO
         fpyw==
X-Gm-Message-State: AOAM532VirLaJwhB52oVPwizLj8o21l2hRQsf6u9EYkOTRfDHu2XMicj
        sQ7hqGIxD9fqezM4yJxWNq8=
X-Google-Smtp-Source: ABdhPJzgXV3dE/YmpoPEhiHF1uxHkm2TbQ7iUL71H1BPo2N7lyBpNUlX3j1SnYiRc4hPM1t1ngZr3A==
X-Received: by 2002:ac2:4e8a:: with SMTP id o10mr10273956lfr.656.1612785672291;
        Mon, 08 Feb 2021 04:01:12 -0800 (PST)
Received: from localhost.localdomain (109241203030.gdansk.vectranet.pl. [109.241.203.30])
        by smtp.gmail.com with ESMTPSA id t15sm719086lft.239.2021.02.08.04.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 04:01:11 -0800 (PST)
From:   =?UTF-8?q?Marcin=20=C5=9Alusarz?= <marcin.slusarz@gmail.com>
To:     alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        marcin.slusarz@intel.com
Subject: [PATCH 2/2] ACPICA: update documentation of acpi_walk_namespace
Date:   Mon,  8 Feb 2021 13:01:04 +0100
Message-Id: <20210208120104.204761-2-marcin.slusarz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210208120104.204761-1-marcin.slusarz@gmail.com>
References: <a3f01a5d-d7a5-8280-4091-b2486b01a782@linux.intel.com>
 <20210208120104.204761-1-marcin.slusarz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Marcin Ślusarz <marcin.slusarz@intel.com>

Signed-off-by: Marcin Ślusarz <marcin.slusarz@intel.com>
---
 drivers/acpi/acpica/nsxfeval.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index f9d059647cc5..7149c8f70a6e 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -532,8 +532,8 @@ static void acpi_ns_resolve_references(struct acpi_evaluate_info *info)
  *              return_value        - Location where return value of
  *                                    user_function is put if terminated early
  *
- * RETURNS      Return value from the user_function if terminated early.
- *              Otherwise, returns NULL.
+ * RETURNS      Returns status from the callback function if terminated early.
+ *              Otherwise, returns a status of the walk, AE_OK if succeeded.
  *
  * DESCRIPTION: Performs a modified depth-first walk of the namespace tree,
  *              starting (and ending) at the object specified by start_handle.
@@ -542,6 +542,11 @@ static void acpi_ns_resolve_references(struct acpi_evaluate_info *info)
  *              a non-zero value, the search is terminated immediately and this
  *              value is returned to the caller.
  *
+ *              Note that both the callback functions and the walk itself
+ *              use overlapping return values (e.g. AE_OK), so user of this
+ *              function can't rely only on the return value to tell if
+ *              the callback function was called.
+ *
  *              The point of this procedure is to provide a generic namespace
  *              walk routine that can be called from multiple places to
  *              provide multiple services; the callback function(s) can be
-- 
2.25.1

