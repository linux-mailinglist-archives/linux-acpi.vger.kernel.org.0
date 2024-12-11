Return-Path: <linux-acpi+bounces-10094-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BFB9EC89C
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 10:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE8D1653E8
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 09:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1463F204F67;
	Wed, 11 Dec 2024 09:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vymOPRtk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0691FDE38
	for <linux-acpi@vger.kernel.org>; Wed, 11 Dec 2024 09:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908500; cv=none; b=bSUjRw5FzgO2csnM2ipQZ0lQLIimB8y7QPWpV837jREi+KHq1uJS62Nz44sf5MaJm+AWb+/cdD5PiK/lLOzro1RZi3X6iHpAsXHg06uOve6zqFpamtJFmJpTn1YfTozBytvQqiz35AXxdMXu9LjPsrKyllfSl4I+nOg2RotUubY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908500; c=relaxed/simple;
	bh=JUXrxkRS6ra3CHJ9SyF7bUw/4jbQj+KL0Fb1Fh2MyHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7vxLV0mltNNPxvny4/dKQniRF7oN5nG9yeX/40RLHjlLQbNffaIyKSb0JzlmaSlcwVmCmmsyPt1cl8iRKFI08WVibc2wudjyup0OTFVwPSlr87Hd2cemzz+KzBYi9VpuNwss7wDE31YIx8RqII6MnTi6IVucP3rkGy/Iy/ruiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vymOPRtk; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3862a921123so3796471f8f.3
        for <linux-acpi@vger.kernel.org>; Wed, 11 Dec 2024 01:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733908497; x=1734513297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6FDO3wL3i1XscIg74LPG2N/BXo43Ca59PIHDAIDDUjg=;
        b=vymOPRtkPVD6OqtxNN3Zn78DuUPGf0D2EtPIVzre4dUGjBcy72cxW+ZKSHV9Uh8NWy
         L+XdJKYILHL2gZ2nItX9wAJX0DeDjSg1ZjXi777nGzj7YWMBE0jvKlIaUwet6VyZUxtw
         QNxJ0CfcHrvC8MEZ2mGb7sx9ZXQqix2buzRBYdfhLEX76dVWIIzfLU4v0AUXUmFoTTwV
         Dy61krov4I8gSzSXaSKRhFqA9nQLxYbJ1fRWV2TAGqvLm9QDPBXcoOvZE3xC1cgHqhHe
         ub1KvME6gyPg5rEe/pnxTaIFo+JKSEpujW2gEtBYZw7JMYz93jvG+/Hvxdw07gBNpXBi
         Dghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733908497; x=1734513297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FDO3wL3i1XscIg74LPG2N/BXo43Ca59PIHDAIDDUjg=;
        b=khhyt/ekh6Lc+b+empqcwXV36ol4sLMY5QERxfcMq4g66HZ/OiiZdOBKIFN0AmYcce
         m2KSMaLZXTKicFYZPYYdEbOBwr+zAXXcDAYOCdqKfw3v2KMAVk3b2E/uEpjSgCkS8xMf
         9WKtlsc+K9H0Gj480chahTypHB/Ea/pmQagfdBYG0VMdXKT183+ahWhEq8WtPCx6N5Ke
         M0G7iuVTCyDuBdmTfV6HLNyWr7mV2Br/sCqCL79+jTciN1YaVzGr9R9+FY77vyvLaUFw
         VyleRa6+PjoFPkqy5QxqItngEcVf8LPtmI3ZjBcW8c96Ut2A/DJP6uwxBprfr1wSPJPG
         SwGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMMSn8FlUKPV4DnCeWkVHdfxNR2F/r1ZWofGtI1HVOImsgEt/8I/q698TlYUY9wOnniVP0KxeniqaN@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2p6DfSSFBVZY5VsvFZw6+X0G/zATREiOgr5dPzEhixduq6SvZ
	54R6k9jRpsHvdjyn3yLyoP0fIy4zyJ1AC4ekuwPXB45ozeFda9ZSmp4dXofO31M=
X-Gm-Gg: ASbGncs4V82Hn8+a61p1iSZawnLBzwPQf4Pb8E+HT0xYEdpar+WDczawq1n6LALOrhy
	b5Xhi2EK20PxXH6wOJ/keJ/x8HUO//z1HVUkiKDeVP4u/aklEkY8Ypd8vtsfaOeqy4Sr/n7Lxna
	wwpD4iW8tEFkJGC7McZnRuYz1l1/ENpvIfb+HbEnrO2otezKidWdrVQ6KSeb8nc2Z2/97VxoX+i
	79XVYb1XDrSukYGHAczTYCenjJn5CILWE8Ab8uuNqjHg8aMYpU167cKfO0=
X-Google-Smtp-Source: AGHT+IHOLK/ljbtyNYazbMd4hvX84Qm4ErHQ/BEuJGZ5dGRRjqOpg37GnjWdhZty1q73L7x1DOcRRA==
X-Received: by 2002:a05:6000:178e:b0:386:3702:d2d8 with SMTP id ffacd0b85a97d-3864ced69c8mr1574947f8f.58.1733908496679;
        Wed, 11 Dec 2024 01:14:56 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38782514dd9sm803351f8f.69.2024.12.11.01.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 01:14:56 -0800 (PST)
Date: Wed, 11 Dec 2024 12:14:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v3 7/7] media: ipu-bridge: Remove unneeded conditional
 compilations
Message-ID: <a91a3993-6c81-4abc-8609-8f41804fdf62@stanley.mountain>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-7-00e409c84a6c@chromium.org>
 <20241211091954.42a5c778@foz.lan>
 <Z1lOCGJvgFcqmR3R@kekkonen.localdomain>
 <CANiDSCvPNf2KiEpr6Tboon6bjUxwEkD=+_AQjhiOA7RDTTpnCw@mail.gmail.com>
 <20241211094854.407ddd54@foz.lan>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211094854.407ddd54@foz.lan>

On Wed, Dec 11, 2024 at 09:48:54AM +0100, Mauro Carvalho Chehab wrote:
> Yet, based on the title, enforced by its description:
> 
> 	> One of the quirks that we introduced to build with !ACPI && COMPILE_TEST
> 	> throws the following smatch warning:
> 	> drivers/media/pci/intel/ipu-bridge.c:752 ipu_bridge_ivsc_is_ready() warn: iterator 'i' not incremented
> 
> I don't think it makes sense to c/c stable, as this is just a smatch
> warning, for a configuration that will never be used in production.

Yes.  Plus that check has a lot of false positives if you don't have the cross
function DB enabled.  I thought I had fixed it, but I still need to work on it
more.

regards,
dan carpenter


