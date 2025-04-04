Return-Path: <linux-acpi+bounces-12733-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE55A7B8CE
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 10:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3BEB16E6D4
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 08:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0F61991D2;
	Fri,  4 Apr 2025 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Le2M4XuM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E533F18BBB0;
	Fri,  4 Apr 2025 08:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743755133; cv=none; b=WjcaEjBn5+ycbYYN8PvYT0sxw3gbbeSZDmTra1zkdnWnRyEZWD6agRV4FwJDmR0NwuGBeWJEvE3r5+K3fxjDZ6PDeVUWpjEyL0w4iTVMdYTNMsGZ/0FfCj4X1Ak+/var4eUOpzwJIKsJdUGFxkj+BdJ4YuCFeZsfPPslqlRkqL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743755133; c=relaxed/simple;
	bh=Pd54fnZYvN0IF3kAJsE/tgFL69YD0dJcke+lyp9URmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzhDxPWrKS72LqqOr47v+RkY/0Br6cOkxoYIraFztvs7hugmvylSFhxtJtUBkPkhoqaE4wQsPYerMuYjbggPs1q4U8S44y4FIc+jhFHfScgGtlhYddVMu/up4kxkcP/aedcXOjo4LuJVGiN9Lnx4LEqBP725DnVDJTn85GOylCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Le2M4XuM; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5eb5ecf3217so3098134a12.3;
        Fri, 04 Apr 2025 01:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743755129; x=1744359929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1uH1IX2xHGor+jIVcJKBUYPSchHEkklHprBp/7Y2BGQ=;
        b=Le2M4XuMAWSnqM8Wp9EbvutSpoDARpjonepbFI9DS8vFgBXEUFV3hQCgcKo4jgoUWy
         oaNp6HXbdtP7045ufFd1VxBKhasd9sL2QkceWy/ikMPPF0MXPbLONAjIZ6miC/FP/JYp
         oqyoiotMYeZEi8E4qyHE8F6UtQR0tHZ3eiHOJIpcDk8EJfuoaqlJUckWaveMtql7SSP8
         4kuhdZamFugyZtaee/7rpq2Cs08wCwrZr+wGd+Oqvbccff36lyKEZNtIPUn8osZGs2oC
         oboEm+dzkYccfsbw35NKI9bF29hEZozQq4TWaEI+IGUEoPTnFTZ86CKYQ0VWKxBNTTqH
         Cqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743755129; x=1744359929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uH1IX2xHGor+jIVcJKBUYPSchHEkklHprBp/7Y2BGQ=;
        b=eTE2qHc+wYCB1I12wqFl878sxSlsmEaqVJPBQXQY7AzkO9YOQXG/FZrFz4A7ZTAAjw
         bNUxWU1GURX5ZOxMJAWkVbdTIo5Sisxq5qeYKRniuOY9r2MZ3CLVIKVpXcclLSE1JIa1
         2H3Sdv8fmHScSA1FhAxEGYED0hhA9WHFPmGbEx1RQD8dCfhOHnj9h5vzIRv1BfoZsJ93
         gG1uQZki/C5d9WvQbEYuQSOFi2hJ26nXlQADbO4XuYFkjIJQ98u67F3VdfsYtp4OD6SH
         Nc+w8mQrTNQ+dYWUKhcjvswJPLufA8BUcJvvmWU57EWxTegbdotvj6t3BIOwIIRNWPf+
         4k2w==
X-Forwarded-Encrypted: i=1; AJvYcCWEERQhjUd71dXkCL7+usfkz5xyfQiYXY9YdBXpVojGYD+NFRBgpPiDanRGIy4ihr7nlmnVWV2sU2AJLW3K@vger.kernel.org, AJvYcCWZfZurGHOvGJEp16ogxn2wQh4Vpw9UBcdI4jtCQTZov6/Fh4XnwGiDZODlVNMPRumUt8MXxBaICvwR@vger.kernel.org
X-Gm-Message-State: AOJu0YyFkWztG7k3Bt/TlXIq193U09k6uAZv37z4n7G6WaC7RnCnBStW
	aLXzV2MlEgdyT1WakBWJ+tyJio8vEsojfFM3VAvAr1aJLKGK6ZDV40p6/s+/sXc=
X-Gm-Gg: ASbGncstrBTrUkYFTh+WSjkIO0LdWGOLidpwK93Xa6g6HensYGV2BfGVzoL6x4v4cgX
	RrBXLkMyvIlgN31E0UFVhNnjb1+Fb4LDR0SnQTCRUlqU+sTlLnIoj69XVlrOjG3McmWdG5jWWfD
	FQS8rT0UrpmjWfgwjQR3eYWW6c+Yrmxgjp2diVbkHVeHsH6eJ2fHGYoh+K91Jvhrb8e+9DUr5zh
	HuniUaso9ARhvV3b/WPHogmWEpYOJTlH0BtMVOCgrkQMTe1m2xUrmeJnETmKcBWdg1enSTs6Q5O
	yhVDLQv/fayPU+PvcR9CO4/tOi1Vcme1Xg==
X-Google-Smtp-Source: AGHT+IFVdlyUKzMf5Pb5awlp9iNJ1Cr8z/mFGTAH8E9fTJUEvs97KMGKq+hbLu5ymPdFCE1kusouSQ==
X-Received: by 2002:a05:6402:51ca:b0:5e6:23c:a242 with SMTP id 4fb4d7f45d1cf-5f0b3bd0a10mr1826431a12.18.1743755128931;
        Fri, 04 Apr 2025 01:25:28 -0700 (PDT)
Received: from localhost ([95.85.21.12])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5f087714df0sm1954318a12.14.2025.04.04.01.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 01:25:28 -0700 (PDT)
Date: Fri, 4 Apr 2025 10:25:26 +0200
From: Ahmed Salem <x0rw3ll@gmail.com>
To: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc: skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ACPI: sysfs: apply ACPI_NONSTRING annotation
Message-ID: <dcc3a018fb28899b277df2e154740d59d4e404af.1743754416.git.x0rw3ll@gmail.com>
References: <cover.1743754416.git.x0rw3ll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1743754416.git.x0rw3ll@gmail.com>

Mark ACPI_COPY_NAMESEG() destination char arrays with the ACPI_NONSTRING
annotation.

Signed-off-by: Ahmed Salem <x0rw3ll@gmail.com>

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index a48ebbf768f9..8a5af261129a 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -307,9 +307,9 @@ static struct kobject *hotplug_kobj;
 
 struct acpi_table_attr {
 	struct bin_attribute attr;
-	char name[ACPI_NAMESEG_SIZE];
+	char name[ACPI_NAMESEG_SIZE] ACPI_NONSTRING;
 	int instance;
-	char filename[ACPI_NAMESEG_SIZE+ACPI_INST_SIZE];
+	char filename[ACPI_NAMESEG_SIZE+ACPI_INST_SIZE] ACPI_NONSTRING;
 	struct list_head node;
 };
 
-- 
2.47.2


