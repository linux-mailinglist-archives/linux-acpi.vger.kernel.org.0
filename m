Return-Path: <linux-acpi+bounces-10410-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF32A04722
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 17:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757BD3A5A05
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 16:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3C61F470E;
	Tue,  7 Jan 2025 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtEnrIL8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF2A1F3D59;
	Tue,  7 Jan 2025 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736268653; cv=none; b=BkllTf6ZzoDKihT2SOuV2oNya76W+hOETPhgz3WCPb2x4BIsJsBfBXfinIHja8NWMFvhstysvGgPVI4u0T8nwRGaBWNFETNCYwziR9ubGtppehMYEETWeThZZy0WgtvabPSpUQPEBuj5ACRKl3cFeXD5+YD3qSyzKe2/2sV/I7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736268653; c=relaxed/simple;
	bh=lMfX1ukmt9zKlMQvTs4rDaldX9Ypcnm+9H1/Ac3eikQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTS5bOO5bQA0VvvTd+WJMstfIymhT+LU1xMO8a9CGIj9wHy5mv24fhM+TXWCTEgVvLoqzxO+4I97vK+7IR2V9obEQJZ/sbwQoe6B7MpYiSIpnvI3dZQOMh7e26DVlIvCZNsCUUGWej1Lt6xWEyNjM7mByvHQL/3wI6oJ16ONZVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtEnrIL8; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38789e5b6a7so7638817f8f.1;
        Tue, 07 Jan 2025 08:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736268650; x=1736873450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lMfX1ukmt9zKlMQvTs4rDaldX9Ypcnm+9H1/Ac3eikQ=;
        b=AtEnrIL8S2J0uRuwZ9Fr7quTMJKWOfKusM8ghKvCMatwjqB8sILkyC8Vmyqjlk2inu
         /IQatpKmpeX4H+sCWMuJmrRL6x1ovj/8o3QvbJ6L/r+Q82TcAta76XtSjhYalYYd5Din
         9X2pa4dHslpVnM6lNbzwTp7vfNVmheLsRT9AgiI2m6gGe/5DAcm5e+X2FDudvPjhHiNp
         r4qHs7uke6qxFk4mnXcGHNNRCsfhfi/d11XxW0aD/jLjdZ+Np/vB9nT+EdEMeCK+5ArM
         qYEKODG1qIhYS2vZ0wDKyFKfptmpfl2s090R8EApbC0QOk+PvgDks9KG/8vZm39BscZa
         YzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736268650; x=1736873450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMfX1ukmt9zKlMQvTs4rDaldX9Ypcnm+9H1/Ac3eikQ=;
        b=VlglCShQ+OfvoXDHORurorxy4cqmeV0HeNvO9I4Rg5lSd5rmsHePmcAbhg4G218NiA
         RhAERJ1S6oAQhAYngO+kVd2HFKlwXbzs7uszAifOUNbtmvZKsvlZsK1dGTymZCG6LpLl
         cBjDXnWmBVRaXVcA8iDkk8xupwFz+fbVNtAOa0DQQ8J9gQ+q/uNm4FKv6EGm1Ag09IWj
         jH2YXQt2J/NQMb6Xn0TOhaY7Ch1Tn6xnuBjigHVaGROhVyIbhEsEsTYJ60epkGZ+BOU+
         n/QUACtFVLoLzDdtwc/2FHYNzuq4+Qle53bywvLdxD/lo6t7kf8eH99LcOOH6nNad/Z5
         c+zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAbOc531RKDXNp8m3X4Xzh32UAPHPYwoCesby6sdV3oZRGMrI8VugbCnVEH1SymQRac27ePVqjIeg5NN4C@vger.kernel.org, AJvYcCX1M319ex/fR714LFTPxPTlT2hwec6vaXm5iOafbPXJpWfrlkA033QOv2kgFUGSyfFXyWPUkwlMus80@vger.kernel.org
X-Gm-Message-State: AOJu0YxDNDfG6zcA4n0YPIfl5TGySdkfGDcGenTlHRwdQF8keVoqbGmb
	CESAzQXG9I8HUPxBT+0ppAtDkos8CbEgT4jR8ntN0mb4xZYYCXdi
X-Gm-Gg: ASbGncvkg1hEJrar2lvMPda2thr8Qwh7CofZafw+rWmRfc/Mjh2N60hWPr5U3SRhSBC
	5rj4BtU7/lr6v4F13hDCSEBpHl8ovPchupQDoAF6EetQNuyPL7pBz666tcq5X4PV0fPJ9nD4ILh
	UZW8S8DmcdeFtPM2Ow49J/VRnVnjGiwY7ZRD4xwJrnBTd1ItMHcjuaGwkeH/OiYUB0BFXufls74
	lf5NjPe5Km+VlZbgGY/G9KOh0w+V+qG+WWxPkWbbXxf5hGblhENwLLno6IKjFpjMQ==
X-Google-Smtp-Source: AGHT+IHhld3Aj2eOg6OSq3UrWdclip0tuLg3hj6E39Paamh0zg+IMdpn2D4qS8+BRnfMsIcynzBSBg==
X-Received: by 2002:a05:6000:4012:b0:386:3272:ee68 with SMTP id ffacd0b85a97d-38a221f9fd4mr57615402f8f.28.1736268650005;
        Tue, 07 Jan 2025 08:50:50 -0800 (PST)
Received: from debian.local ([84.66.149.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c832e8asm50137086f8f.37.2025.01.07.08.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 08:50:49 -0800 (PST)
Date: Tue, 7 Jan 2025 16:50:47 +0000
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alex.hung@amd.com,
	regressions@lists.linux.dev, tjakobi@math.uni-bielefeld.de,
	rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amd: Fix random crashes due to bad kfree
Message-ID: <Z31bZzkjySUgoOkM@debian.local>
References: <Z2yQvTyg_MWwrlj3@debian.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2yQvTyg_MWwrlj3@debian.local>

#regzbot introduced: c6a837088bed ^

