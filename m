Return-Path: <linux-acpi+bounces-9736-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2B69D5C53
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2024 10:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3009F1F2248B
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2024 09:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE98F1DE893;
	Fri, 22 Nov 2024 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XKlev80f"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3E01DE3C0
	for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2024 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732268905; cv=none; b=A2K7cLMQViBqFKEv2DK1GmVixICrrBtkViDgejouxbG1I7S23bj1ZVKk5TJ2gsZpCdGjgPD0Uy9gechkeM4amcNlRWkVjIdR394lmLZoOs9xj9P1XG9eAxShcpUqWGL3wJ6xCDsRZkrb0egLcrxVpJknnokrLC3Xo3lWyPCxENc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732268905; c=relaxed/simple;
	bh=sHpIqPIcR2Hbo49SEnSkc9fxU6SdQ6Gky5F7X03Wuxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RcjHgeQJ2JWFvfEJCh/czTYTJ7JOlXJa2bPFt4CbY1TQtzWgfcVQ3Rq1r1whZyHlmkEbjBdlIJ1El5TLcF6hz+8nr5buFFVxumk2yajCjXGg7wXOobRWBnPnmVSRzs44ejuRUK9wV+zTSjnJEvR47ZIkAPpIeGaKgkAnRYLxcOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XKlev80f; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-460ab1bc2aeso11564901cf.3
        for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2024 01:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732268902; x=1732873702; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9GJCP1X0CqpJdW1fWNKDOtb2VgDbT9PrS/YhQ90tFA=;
        b=XKlev80fU0zJRVhQchANLOn003FtfmXIhADc9RkN5HhvL4TZs5vbqbSQTSq5LIZfsI
         jrLrxLYzGBoOBXJ7uNx4hLU2NItVB1JtpZ1tc7zy45EFMLjAQSWKqWLohz9SKSedIekJ
         jF9U3fl2dxHT5ZhqOTnrcvZMKFQAO+Ej1xqAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732268902; x=1732873702;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9GJCP1X0CqpJdW1fWNKDOtb2VgDbT9PrS/YhQ90tFA=;
        b=DtphpRH909BZQHLdTmQqKqAdiPBm4mL3aYEiKr9hduK0jA5QrsoJrwACo1tkqn5fo4
         QQop1vAiWS+9xAgGzskQsHaBXZ9Jv0cPAQpAVgJgw4TGkHbBVTv+1GilM9ZVU4mSsYQf
         RAwCM5o9/56PgysL3AejPxLRoMURPqmE4FeBkFjW6gzIliL35lJuH60IEPUn5mOY9JXE
         DRPesF5bps39qJcVSu/z3fCCxSEkEtnoB34geTd7Yfb1lhuZy4tM33ch+c6RmUzfGmoF
         1gg6MtHllQv6Y/MkcqEnLm/IIYrnODDuPALOCCGNKoBFg4etIXgxIcpEOaS1L7+2fnuG
         lu+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxF6Ws9BCVJU7n155JOqL+jgHdv9htMivchygEpSU7+JFnv73xqRoIRtpXv2yibUuIXfPnowaFDPe4@vger.kernel.org
X-Gm-Message-State: AOJu0YzM3qpAxGAeCdtVhCO+OGVyGURTMItV+2AgnAVWHtB2gzj9zVne
	3tJ8KkrIjxFOoPUOPJuer6GCY1gO9i8JT9vDqmxWwT75ynot4TIVENgo94pKJQ==
X-Gm-Gg: ASbGncsygIPSIxv7wSCAaLvFPyWvB0b1fwr+1aXnhPcqiUqRBvtCcGHOWmDHNQmOW0S
	X3nP2yx8iAnnafEOW2+XvnaGRrcDhb3MKkXdnKtUpaJf5JkFXf8ZLPRMRYqtlVMxkc+/YGhGeho
	huIyHNkHvyuhgnrfL/V+S1E4QS48TEJTbygy4AP3vVilu2NUHScmmVNTHaOG3hX8n6fPiPdNwcB
	DZ9az3iXqHgHfHbMh1t9909X4E35iLLIF8LFCIJo0P5zhwUoaPQr1NzP96S0DlsDwnd6lmq1+4a
	aK/isZbWtQZZjfFF+6RndJbT
X-Google-Smtp-Source: AGHT+IF2+E7hA5csqndp9Lp4Yhj03h88SxplMlYhJShe/LVL3nGthWIokV9jzsEcGM0TTVk5jNqFjg==
X-Received: by 2002:a05:622a:590f:b0:458:33ce:dcfc with SMTP id d75a77b69052e-4653d62c171mr29716911cf.48.1732268901824;
        Fri, 22 Nov 2024 01:48:21 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c47f124sm9282731cf.62.2024.11.22.01.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:48:20 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 22 Nov 2024 09:47:59 +0000
Subject: [PATCH v2 2/7] ACPI: bus: implement for_each_acpi_dev_match when
 !ACPI
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-fix-ipu-v2-2-bba65856e9ff@chromium.org>
References: <20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org>
In-Reply-To: <20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Provide an implementation of for_each_acpi_dev_match that can be used
when CONFIG_ACPI is not set.

The condition `false && hid && uid && hrv` is used to avoid "variable
not used" warnings.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index b2e377b7f337..eaafca41cf02 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -1003,6 +1003,9 @@ static inline int unregister_acpi_bus_type(void *bus) { return 0; }
 
 static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
 
+#define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
+	for (adev = NULL; false && (hid) && (uid) && (hrv);)
+
 #endif				/* CONFIG_ACPI */
 
 #endif /*__ACPI_BUS_H__*/

-- 
2.47.0.371.ga323438b13-goog


