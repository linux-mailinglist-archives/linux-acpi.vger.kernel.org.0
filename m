Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3A0319E6A
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Feb 2021 13:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhBLM2d (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Feb 2021 07:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbhBLM1x (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Feb 2021 07:27:53 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5482C061574
        for <linux-acpi@vger.kernel.org>; Fri, 12 Feb 2021 04:27:12 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id h26so12839704lfm.1
        for <linux-acpi@vger.kernel.org>; Fri, 12 Feb 2021 04:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UWn+rHFAan/ANPtPozOJVkaHRnjfc/Lya2Pf10dpvvU=;
        b=cuM8y0tVapdBE+5WS6skBCyQS76KsRGmf07HVjzvFqPSh0CqBLXalH3NB3FMpibYYJ
         tShvMS6gzYNTAtV2Iab2lPFvQGE284T11FL/N32ZSBi5+F1wdhgoWQ6pZk3kjZBniwdR
         X++1PtJyNglndBqKfQ76I23esWp6Q3t25kId5HkQGVdp6WXPbdyoGbvvVZEcOlu1hD6M
         ZjFvbVuJJF8j/e/9wTT8YA4e2iLGlzEJQ9PZg4sBTUxuv+VVYVyzp+VGPoMlBB9Wx3Aj
         k6PNr3aENa0rfnIv98KEW9pfA6ra/WCWy+X1z02Q1TBAfsH9m6xr9Nk5Lu0xSZzyKd00
         Sfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UWn+rHFAan/ANPtPozOJVkaHRnjfc/Lya2Pf10dpvvU=;
        b=OKaTX7GPqNKYYV3evTwKckz0yBJbk6faMArFoTkFb3rPKYrgxIkqC3kKnla/tj2DL6
         Traf57N5oPTN/e2CO+E1DCR9OzTneEh4uKHe8LCzx48pFxx7RN05f5BCK1mkn8wcf5qn
         Hogh+oelYP9tkX5lXQRHS7JMVe8P5TdgodjBmljkFu4pHKlIT8x15iq2F8wpHYfSJax4
         9MImMT7wzEWtbNADe3hANODJnnqpGjXxoFbu0AmV6LbfRVYPbN8lglg+t9dQlADMdzDX
         e3Z4kiutJwsTCwqMuz6ZsrJoXorrTHun/hrmnMmO2qnGX/98CpY+q+iaDllonkvjhWoS
         67pw==
X-Gm-Message-State: AOAM531c4XmOGQcEayBOKqlcf59oRJXTlN/VJclZyo9K2gIGTH29fjBL
        9WS8woBOc4o88Y5Ib7dqq5GOQoggqIodhQ==
X-Google-Smtp-Source: ABdhPJzSOvbFRvhristQ1/42KrVkKajRy4IVjFVyUAhBxgNuJxon+pN5Ah6CXXJ1D1Lf5/AuyOM9IA==
X-Received: by 2002:a19:3806:: with SMTP id f6mr1516358lfa.242.1613132831191;
        Fri, 12 Feb 2021 04:27:11 -0800 (PST)
Received: from marcin-Lenovo-Z70-80.gdansk-morena.vectranet.pl (109241203030.gdansk.vectranet.pl. [109.241.203.30])
        by smtp.gmail.com with ESMTPSA id c5sm262036lff.113.2021.02.12.04.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 04:27:10 -0800 (PST)
From:   =?UTF-8?q?Marcin=20=C5=9Alusarz?= <marcin.slusarz@gmail.com>
To:     linux-acpi@vger.kernel.org
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, marcin.slusarz@intel.com
Subject: [PATCH] ACPICA: update documentation of acpi_walk_namespace
Date:   Fri, 12 Feb 2021 13:27:03 +0100
Message-Id: <20210212122703.272005-1-marcin.slusarz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAJZ5v0jSqmpnbpahGBRSjddOecqA1f-9GfvNwjdV0pH7xQ3iVg@mail.gmail.com>
References: <CAJZ5v0jSqmpnbpahGBRSjddOecqA1f-9GfvNwjdV0pH7xQ3iVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Marcin Ślusarz <marcin.slusarz@intel.com>

Make the documentation match the code and add a note regarding
the return values of the callback function and the walk to it.

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

