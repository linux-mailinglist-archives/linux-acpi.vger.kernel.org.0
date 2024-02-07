Return-Path: <linux-acpi+bounces-3273-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE7584C688
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Feb 2024 09:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E753B261E7
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Feb 2024 08:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EDA20B14;
	Wed,  7 Feb 2024 08:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="osqGZLas"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2886B208D3
	for <linux-acpi@vger.kernel.org>; Wed,  7 Feb 2024 08:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707295502; cv=none; b=a2eZc8gb2xp9X9miUQy39F79aizFoaxkSH66HyVwDTkoopGUQ3OMUlSzkTWJzeKZeQp4kYodGlo+aKVnlUkMKL89vpb1L6ixWyijwOAASkC8Su6/aC/hAq/y04YWT0e6dT9aSkPlWBmMxVpLKNxxdYWWo22UAhOZKuwa8MswT3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707295502; c=relaxed/simple;
	bh=YTPZcSINU7lQwWahDe2E8XZsVbApJNCaAHRu8Dse6tU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YnLc2iivoxbfPDNSov7RQubuEOX6tH0SMJeL3I7j3qPSaJGXW9ITgKZScD9rJDN3+GkO1mC7wPXqtDYSeaKT/TR8v95kC4JpBfnRaxLdqx4xpzLAdqTSyDZNtFQ4AeKJaqD5QYzWCh+EyqJw7q1NPZeGtAnz8vHbk4+ZgmztPgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=osqGZLas; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55369c59708so65484a12.1
        for <linux-acpi@vger.kernel.org>; Wed, 07 Feb 2024 00:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1707295498; x=1707900298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIQKW6QdXz2vaR/7LGjw7ltrzBRpHViscM3vHYU14HI=;
        b=osqGZLaszV5i952siEuXVuXpU4pa2ukrtQTJ5NboL+LFW/HD3NFChW/6s8ZIMQ/ATl
         PMgZio+MSsL/YkZaW2PJnQ4OGdkJQ1WTWpkZ2mn4pw3HVe8ifkeI4kXMq7Qng1ewkXsZ
         7/C8H1i+kYVBbEZg4GoVvRyWd794YkqY48V3z/XmwqDlGJALSafSMUZVNQO77/ztdKnd
         Zrb83d6qqNgACfZH4IDyltWGcagPZ8gyef2R2myC6E8rwt5tjqU6AnSXaGGL2bFjTxm/
         CgvNxodJgGTZj5iOtpSE9wgdpbZGx25coHhYJYaulYAsBBZp3PqkQu09yo1lXjhz5i/2
         311Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707295498; x=1707900298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIQKW6QdXz2vaR/7LGjw7ltrzBRpHViscM3vHYU14HI=;
        b=enmAeQKbu6Dg1uV97ZD+b9Hgmbt//Fv4cfD0OodIudZKxZ9O3DITK9OO+en99A5WYa
         Aj/0J2ea7njXjQCETt5e4Ro6wS2YyHVKSeMiMUUvN7PwwKjZ0XG5NHfkPxr6k6MMTrcZ
         GpwHDJIh0oRyrK6DUOtmeWwsqRceKMC1I59S+CVVrHU/F7dpug82ccZRrrNrijvrQMRs
         P6SFipUB1RKrMwGAQSyGXwlKXXX8HTauFp+sbqre+r4qDLYDSPGMaFblI6Pf8wx/rqS9
         e1lxn0e8rd+bkWAdzNFx1PsEwSKMw5szFkQEuAbihgLw+GXOh/DuAwQ+93zn01dSulRr
         xkeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxdxUW0ooApXVDEFTVduAlo1bhx5TvapSetX8F9ky19jzwnfzZGSKQ6pXuBrWzUYpHxfqnsjJ1wRxCI9GSnzMllAwffCW7LFQrLw==
X-Gm-Message-State: AOJu0YxFd568jX9nUFSTgNgNiP/iDYZbkD9e0DLNKHParRWxWCdbERTS
	rcDgNxWxRGusPrOixjg7BMGyGojzmZRZBR6jKZ0vEUHN2iD4hP+R3ajrsee8rz4=
X-Google-Smtp-Source: AGHT+IFWzKnhbhGinj2qOQCqkp3swKH8rjdtW5bBb/QgmZglwFyBoNmw4mMFkpf3Vxg3rpxHHgSqkQ==
X-Received: by 2002:a17:906:468a:b0:a38:24ba:99d9 with SMTP id a10-20020a170906468a00b00a3824ba99d9mr2634457ejr.6.1707295498258;
        Wed, 07 Feb 2024 00:44:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVGH4z0ynpHbcdPWjccBmirwpr3RXHiKwQz/4yWilxX6y5d8K7JDWFBuswl8k9B+OKS9Mm7LXDGgBtK6rMDrNslFrHbP62gg13S7+N1X3kONw5MQ8vfM6kACCRtbo/IgWf/7Y33j669EFCiyCXAb94QwiatHul1ddzcqMJjAGefasOy8kOQV9rHnwdeZIzlEmu7m2xlnQehh1ZY4Ob3SWmoqKC7BnghVi0bpOLYsTaUw6Hw3zDeWlAUPm+XtqX5m393cNJcG0rdo6z3PHyxCH7OlrKeUOARFLfvYOc37lFI7OcLXlrhRlW/KhKZ8U6ye8iLMHBG2X0XrOEdoAqig/oaLdO6dVkYYGSaIAPbOkS62rNxP2V9RfdVQ5Wl9SpZVjc0PZY3Z/b003h539igAtOurKUFp4IueZ3vdsxx+j4kHrW4hmASuX+1vUBuayzxDLYeLPCsrho=
Received: from limbo.local ([2a00:1bb8:11e:cb8d:24dc:94bb:6d8:7d12])
        by smtp.gmail.com with ESMTPSA id u25-20020a1709060b1900b00a370a76d3a0sm493921ejg.123.2024.02.07.00.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 00:44:57 -0800 (PST)
From: Daniel Drake <drake@endlessos.org>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: hpa@zytor.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhelgaas@google.com,
	david.e.box@linux.intel.com,
	mario.limonciello@amd.com,
	rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux@endlessos.org
Subject: [PATCH v2 2/2] Revert "ACPI: PM: Block ASUS B1400CEAE from suspend to idle by default"
Date: Wed,  7 Feb 2024 09:44:52 +0100
Message-ID: <20240207084452.9597-2-drake@endlessos.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207084452.9597-1-drake@endlessos.org>
References: <20240207084452.9597-1-drake@endlessos.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit d52848620de00cde4a3a5df908e231b8c8868250, which
was originally put in place to work around a s2idle failure on this
platform where the NVMe device was inaccessible upon resume.

After extended testing, we found that the firmware's implementation of
S3 is buggy and intermittently fails to wake up the system. We need
to revert to s2idle mode.

The NVMe issue has now been solved more precisely in the commit titled
"PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge"

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215742
Signed-off-by: Daniel Drake <drake@endlessos.org>
---
 drivers/acpi/sleep.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 808484d112097..728acfeb774d8 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -385,18 +385,6 @@ static const struct dmi_system_id acpisleep_dmi_table[] __initconst = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "20GGA00L00"),
 		},
 	},
-	/*
-	 * ASUS B1400CEAE hangs on resume from suspend (see
-	 * https://bugzilla.kernel.org/show_bug.cgi?id=215742).
-	 */
-	{
-	.callback = init_default_s3,
-	.ident = "ASUS B1400CEAE",
-	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-		DMI_MATCH(DMI_PRODUCT_NAME, "ASUS EXPERTBOOK B1400CEAE"),
-		},
-	},
 	{},
 };
 
-- 
2.43.0


