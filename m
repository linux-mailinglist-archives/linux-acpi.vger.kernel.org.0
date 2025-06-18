Return-Path: <linux-acpi+bounces-14451-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BA7ADF21F
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 18:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51B673AD909
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 16:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B32A2F0022;
	Wed, 18 Jun 2025 16:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LijKba0L"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4382EB5A3
	for <linux-acpi@vger.kernel.org>; Wed, 18 Jun 2025 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750262552; cv=none; b=OJMe3ao15BbVo90pAK1OnY78cjjT/WkYmoNUeDYCVNYUJkLf8hnbK6Ogp/tKDMXNs5XYBv4tSJtge7A3g8LixdtkanMKt2nH7+cgulyBZSQk7C75R82TYkfAPHmT4xZJa0e3IQpI/RtLKmjcEtaQP8RKaYFSdzPX16JpTmyJew0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750262552; c=relaxed/simple;
	bh=szpCxpm/j2ZbcXcfCS9kCbBVMGO+lYR+TOvNQfWht2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkEKtx/NFReVcdYiTWQ9lwQ9lPkzHoxUJ2X5IYAvBI4ILyhdEmmcwXjdTMT9LnZpfXYd2S3POrxuaqjF1+gh6IoMiPHZZCQ7UZXnL6s4DFhO3j8c36hSTcjt1h++OoZd+wTuNGCBGUuBR4Gur5w9h4C8e+sYEXM30hrp4YVLATQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LijKba0L; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-401f6513cb2so511909b6e.0
        for <linux-acpi@vger.kernel.org>; Wed, 18 Jun 2025 09:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750262549; x=1750867349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yHWHgwA/STLjiBuexUHGmnhpSwfTae10x6GG0C7Yl58=;
        b=LijKba0LwOio5PKcfPJHGJj8p/7ATCv3EVfcxwvX1Swv95zZWG3k/ayHqEZOm8YnNc
         XQkrxq/6pjXIEnq6PTtgBHTVS8y1sYGJNqhJQBwsyNjwAPblhm2iRrVxU62FxCRMY6rZ
         D2g8Y1RLT3KtJrp66E9ORS+efui1VtIhjo8upE6jqyRBivRli42hRJ6eDhzNfcLeAN7U
         K9PtSXtWT5mGya8OFt0dIZ/XdSemPHNhBz7WDHsx8JHm5VJl22mwph7ESUccg2I0Uk5V
         7Hn243BsD/HZI//gcF9Eo/MqAhtYQXUU51EYCNZTLSx+WW0yX5KbSEabwud28+cRqiEB
         sqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750262549; x=1750867349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHWHgwA/STLjiBuexUHGmnhpSwfTae10x6GG0C7Yl58=;
        b=nlPz5EiQB1+DjsxZ/pab+LE3Xq36OL+qEKDwmhclJcXHPCtfuFToUXWqnz0zOEro+Z
         Y6V0jMgJg9fP7+qVI7g6WgN8K4e1UheaxK9DWjnvZEGeve5jk4TfHbRt79KD3WrR6Yn5
         bydij6OqTqENIIzA3V8kPLf9QyI3PSrVAA+NmIpFQmf5DVnZRlcno8gwLhjrhSsN2646
         KqVSGMpSjxm8EjV8avKJU449an3a7FqV7lPUPtfQkRHhBU/oMttHm6eEf4vZ46uYffMX
         3DD3DGqtytxYz1VqTsoiNF/uaGkqdC6vYXU7D1OwUDoHa0b+oZb+2fjIZ8AKDJfoEDT9
         0ljw==
X-Forwarded-Encrypted: i=1; AJvYcCWgRcqspZVpGfSQVAiJeNxrSzoZzrzinTW2y5L+zqtaDRNSjVjhnQHTbBWeefAFlKvMIjPJRdUhs6J8@vger.kernel.org
X-Gm-Message-State: AOJu0Yww6w8yM3/aOBD3kM+ee1GCQl8sK2Q/7nR96uylMOARD1DFe8LB
	D53SPwWXan/HZpfW6qnavwIIPmckbYTu9uUC+qKnZQJIZvhfa7yPJJdRfeupfhtCGWo=
X-Gm-Gg: ASbGncsTtWPI8c5Vs0yXjE2+D37OhD8TQRmiXOgH6jPfE430GKeyWjWL0CeKtYkvbF2
	f2HePh7McMuBdnQlmkK5HBtZdVjfk1mENp3E8sFbGbNgHYwrwDiODLWuHCYU1G9erOSW/lB+Qu7
	HrgN6aZg/txPC1aNNoV2GZFX3C7N4CvKwZRNyy3ACXT1T4RwAwhP/uLEpDXUI3w/+MpWpthMtay
	0OPydsADUO9q+Lwja+DP6ZwwP9WDXAp8pbAOqj4LFvRuoqiIjeo1gAGWAtqvImVWvLZWBWqUxxn
	+/hZJZbaL7BmJqvXqIdTq4AO8Mi3sI6pn64pu+Vp7MXfGkw639A+CkrEh+vtjr/YzG224Q==
X-Google-Smtp-Source: AGHT+IFdKAGH3Dc73tUBzIIxeMD+asyvvqOBafuZVazwZnURkN8zz0IH1vKpB9D7wWwudeN/TRUMfQ==
X-Received: by 2002:a05:6808:4f26:b0:40a:5380:b8d1 with SMTP id 5614622812f47-40ab510f58emr105690b6e.3.1750262549102;
        Wed, 18 Jun 2025 09:02:29 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:1b3b:c162:aefa:da1b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73a283dc98asm2012193a34.11.2025.06.18.09.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:02:28 -0700 (PDT)
Date: Wed, 18 Jun 2025 19:02:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zhe Qiao <qiaozhe@iscas.ac.cn>
Cc: rafael@kernel.org, bhelgaas@google.com, lenb@kernel.org,
	kwilczynski@kernel.org, sashal@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2] PCI/ACPI: Fix double free bug in pci_acpi_scan_root()
 function
Message-ID: <f04d01a7-28f5-41ea-85f6-ba0e67c80428@suswa.mountain>
References: <20250617023738.779081-1-qiaozhe@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617023738.779081-1-qiaozhe@iscas.ac.cn>

Wait, what?  We can't just delete pci_acpi_generic_release_info().
What's going to free all those things on the success path?  I
don't understand.

I had suggested you do something like this:

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 74ade4160314..ff5799b696d6 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -1012,20 +1012,20 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 		 root->segment, busnum);
 
 	if (ops->init_info && ops->init_info(info))
-		goto out_release_info;
+		return NULL;
 	if (ops->prepare_resources)
 		ret = ops->prepare_resources(info);
 	else
 		ret = acpi_pci_probe_root_resources(info);
 	if (ret < 0)
-		goto out_release_info;
+		goto cleanup_init_info;
 
 	pci_acpi_root_add_resources(info);
 	pci_add_resource(&info->resources, &root->secondary);
 	bus = pci_create_root_bus(NULL, busnum, ops->pci_ops,
 				  sysdata, &info->resources);
 	if (!bus)
-		goto out_release_info;
+		goto cleanup_acpi_pci_probe_root_resources;
 
 	host_bridge = to_pci_host_bridge(bus->bridge);
 	if (!(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
@@ -1053,8 +1053,10 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 		dev_printk(KERN_DEBUG, &bus->dev, "on NUMA node %d\n", node);
 	return bus;
 
+cleanup_acpi_pci_probe_root_resources:
+	free_something_with_probe();
 out_release_info:
-	__acpi_pci_root_release_info(info);
+	free_something_info();
 	return NULL;
 }
 

But you'd need to replace the dummy code with actual code and
change the callers etc.  And I haven't looked at the actual
code to verify it's a good idea.

regards,
dan carpenter


