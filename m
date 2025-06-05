Return-Path: <linux-acpi+bounces-14156-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04629ACF2A2
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 17:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0CD6174857
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 15:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891A22749E0;
	Thu,  5 Jun 2025 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Rjei+jQE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6A9274674;
	Thu,  5 Jun 2025 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749136203; cv=none; b=LsqgsNXQ59g0+YtSMn5YoNusJLdiYod1BpHM+Ji9KK4px2uZMuj51hphLIKwr8a1iRJCV9oZOFJ71ZSzCYSDx3MirQ9n0IyyBLtY4HMgZf/Hc/EeNN2uLE08OifAJaBI6WtJSf6ZgXtpq9QobWuy1S+pzFye3JJx0ctBJd2uUpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749136203; c=relaxed/simple;
	bh=bTK12/RHj2S92BeBsmXm3twq1jNQ51lI/Rv88YQ/aXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2Tb0FZj7/z0+olQAwDxdOeUOefomr/q6ry+Hkyc8tGlu9n2/7BRhzqsPIRhJEzecxbwGiysO1P3b+YPJIuWd7tclGI1IA203eE6pUaZqDIBatorceZNoCJa1uLwP5HBHaZ+wZ6bXWMnUvtqHcaPLDizoxzRT2BbolyXKXqgUY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Rjei+jQE; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 3403866C03F;
	Thu,  5 Jun 2025 17:09:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1749136188;
	bh=bTK12/RHj2S92BeBsmXm3twq1jNQ51lI/Rv88YQ/aXQ=;
	h=From:Subject:Date;
	b=Rjei+jQEe4HRp5IYN5lQKpWnxOKZQPmGBOZizQ3mISC/WDYYpftXuTGHnZvuZefNy
	 bhD81v2tnvxj/Lk+kWoqRzce323YCLFR5g6CS1dnXEnr4Ye9OPX/nt404QvBl2Nhdw
	 FAdCk/1Uh8BpsUD5N4kO93uaopgN3YFGImTYoInIiZXpNdu4vUn8E/lDZYoXAWCvBY
	 D9rRCyGPy1oRRlgYjL6Ewnq/c9pctfDXIEsBTLlZ31sQgKVQC454Nb7IUXnbbe20If
	 /88kDgn5XP11lIwf69vDOCG6g2+xXQ9bNABi+0DTKYXAJuSuzUEdU8+SPlTFsPeHON
	 NuBJJlwC8LnsQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: x86 Maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Linux ACPI <linux-acpi@vger.kernel.org>
Subject:
 [PATCH v1 1/5] intel_idle: Use subsys_initcall_sync() for initialization
Date: Thu, 05 Jun 2025 17:04:11 +0200
Message-ID: <2994397.e9J7NaK4W3@rjwysocki.net>
In-Reply-To: <2226957.irdbgypaU6@rjwysocki.net>
References: <2226957.irdbgypaU6@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 5.63.189.50
X-CLIENT-HOSTNAME: 5.63.189.50
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: dmFkZTEzSEGzZ/ONVrWENr6vcXfS3S2jicISDIUk4t6WJg+Zjj/tMsiKrH6p/W9hVn65rDd2JKDd5uTYEHknKQT2r7pOoqF3rdVD5yhK7Rprhh7g9Zvcj23lpp2rY7UCLtUpLjrE40L5kP2ENOt7F7JFMQrsU0BxCSyD9ImwCg/5uHKqloLfTfX1B6buKhq24d5iBCDj1fuCRg5EDPCCcGoXCAG/xJ8DxnVxdLMqNeA6Murrcf5yV2bVSf0qD3cTb1ZGJEaagT8ZwEZw1hwmHq4GBUTZA/geTkMBRKK8IMyXCx4LjU27eYT2E9Bi7kPkpz1heTPAWpmaTKgTxzYdBmQllqRTqp5hI2qVAztydhuc9OIhrfm8tVkLl+tEEx8J57dNkSdDHBRibrbHQQ/dI1nVVxlucjsxGlJy0vLI1S/yWVtnHWCMEjwqTqBFmBlbwqpGp+7kB1mv4YNwdfjpgeNUHqaegGjT69Yztk+cYg4Hco9zEY88fIrtxTkFfC6hVJjMAT5Siu/nU09LsKTqeX9DFXJhpjdMA+LF4nKOfNh6BOUl7WPQGB+fbW7FpkY3RZ8eeIwfn3dr/W6U9qygDIGtGcE/7l9vrHxhgVZtOGNfpFw+eq+c81I0aPRpWPXvO2WJmSJVc0TnRblACqvysNtxP5Y8G+APxiFpJZOhkuE2JzL9Jg
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is not necessary to wait until the device_initcall() stage with
intel_idle initialization.  All of its dependencies are met after
all subsys_initcall()s have run, so subsys_initcall_sync() can be
used for initializing it.

It is also better to ensure that intel_idle will always initialize
before the ACPI processor driver that uses module_init() for its
initialization.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -2517,7 +2517,7 @@
 	return retval;
 
 }
-device_initcall(intel_idle_init);
+subsys_initcall_sync(intel_idle_init);
 
 /*
  * We are not really modular, but we used to support that.  Meaning we also




