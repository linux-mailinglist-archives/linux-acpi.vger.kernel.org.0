Return-Path: <linux-acpi+bounces-14578-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9B5AE7192
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 23:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0EB17D06D
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 21:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE3F25A323;
	Tue, 24 Jun 2025 21:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bym0BXNQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C591C5D55
	for <linux-acpi@vger.kernel.org>; Tue, 24 Jun 2025 21:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750800676; cv=none; b=pX4VncuqYq3VETGY2y/leVZsgET1EXntwlSHfnpa4fAT1zg6XG7fDLg2drrMkdgryAkzpbS/l3M9LJVwoh8CRtbxLF5xTRrRcwAIKi8m8A3/2hQcOIciwu2JPDM4TntSFl/OHvfpJvUAuQslCPD1m7VcQTrOcjKJiPgI9chNjmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750800676; c=relaxed/simple;
	bh=iWJFa+CoIH1aRFa5s3weT2eEIVY61koUp8gTnMer7bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAOw9sBkX/fTUTZNCq3Lou80WHDbcIUWpS2xqZroulefZoHSQmE91b2Tf5srBPNbPIVSM8MNXgmQWgJ/rdEcSQMneappOex0B24cA5JKsQPsHT3gmf4UdeMuazFoe6JGSZkdiokCagW8xr/9RMLYmYso8hz9nrHUaPBH+HjooMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bym0BXNQ; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7387f21daadso186163a34.0
        for <linux-acpi@vger.kernel.org>; Tue, 24 Jun 2025 14:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750800672; x=1751405472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XAGh8Jym7W9mO0APdl/bJnVSnx4qhJSlcOpA2Gqe/Y0=;
        b=bym0BXNQpXGMLBHLocUm0zqvfsOFYbXxOVJfwZYNWvv25LS50GAbkKY9YD1GZv5y67
         /KxVjZukDlVe/XJYpefFoZBQXoeBjMphVftQf35EiT0PMcsSwrdnP6whh4pFUKmDGmcY
         stB0Aj7BNZBtIhzWSJhWwICuiO5LPVDLPyQXkFXQYd8NVM/+iTxWSupykXF1ewdWLKT7
         A7HGEoojCRNmw3bH0POY4ei+XjxTkNsh4XNgSuUoBVRs4xgtVHDVaD7c3WsCChKTPVGA
         VxmpHEft0uoLlQBpbPAc0FKuJIoEUtUTxX/s4l7v1f4QU034rsqL6D5dv71B1yQsCN/P
         qkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750800672; x=1751405472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAGh8Jym7W9mO0APdl/bJnVSnx4qhJSlcOpA2Gqe/Y0=;
        b=c4UhwcLE1EsJmf3omNdpksh4+NTp9iMtQBt45/UrOIOkYgiAhKq4wApcCbLDupTFvO
         KccdvK72XxzpyjAzoGie0/t/hXWEdrITmj5j0w4tqyqCAyHlxZGhk3g1ZdY7dk1WL11h
         hjhm80xGGhWV60CfAP48R3v7RytrAHh4pcMFZFa+8IF0SkK8PrjlMVFjstO41q0zFOy4
         nEwu3H7wa8Mh/SsgdjF+Abc74xp9WXLch+96yitpkdUuHIeIs8mYavNv1XtV8SjRuaUP
         hseLde013fjnOn1NU7WVLn7t9tk8xL7QTZitPC0TKPV2L4zeok5ZuJuwodJKehBCueb4
         I/zA==
X-Forwarded-Encrypted: i=1; AJvYcCVANsxXn39dPh+vi1G0DpBri2FlA5oo4IHB/1iObAgFlWZnrwZE0daSep0jAW4UEFn3SMLko4iHJqXu@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9y9kP9EGlb3etEeFNJjBnPgFUmu9tXnpS5N47vKweRzom/7NH
	KeUnI662br3tWVjnAtiOCTxbbjrXO/WAI+RU14r83CK4QQy3WflB325UCtETTasTQIA=
X-Gm-Gg: ASbGnctefUqse1H+Pwv0rSQctiJRI+/wQRVRxASodNFmeatud6VWCsb0RPfFByhYR37
	+/R3IF7SzWwerl4wkgacEEMTeS/pei8pLLYv4zJv2LuKYyUiYGhCaUqE3q13S48aFe7/lIqUUKl
	30qsfty5XuBR6qMcauQnKtC/YJR/HCT2BEG3fRCIG5OX0gApciGGaaJAmJt7TwPhV1RnIYIvTyh
	O8v9IlepqP5dXnmngC2TjrXYRSDwBrV7DYGsdB4DlP0FsOepehpQEcJJCj+v96uxhszrvtq2vvh
	+WEk++mFcbyuGBAL1cwQZt5yblNm52EL4ztmpBfx80PszXi2ROacmMh3SzFnEP492kzY5g==
X-Google-Smtp-Source: AGHT+IGmNlfw6NmkG1PAAGja8E356NKpTSGC2pBqHIlxBkBODoIakpD5CgLpL86zGjAuJM9IDxTukg==
X-Received: by 2002:a05:6871:607:b0:2ef:88fa:e0c3 with SMTP id 586e51a60fabf-2ef95cf0d15mr3262805fac.13.1750800672473;
        Tue, 24 Jun 2025 14:31:12 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:22c9:dcd3:f442:dd1d])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6115b68edc8sm1449545eaf.7.2025.06.24.14.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 14:31:11 -0700 (PDT)
Date: Wed, 25 Jun 2025 00:31:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>, Ira Weiny <ira.weiny@intel.com>,
	linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ACPI: APEI: EINJ: Fix check and iounmap of
 uninitialized pointer p
Message-ID: <31b6548f-8ff7-4bc5-8a2c-78a5a9d5eb40@suswa.mountain>
References: <20250624202937.523013-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624202937.523013-1-colin.i.king@gmail.com>

On Tue, Jun 24, 2025 at 09:29:37PM +0100, Colin Ian King wrote:
> In the case where a request_mem_region call fails and pointer r is null
> the error exit path via label 'out' will check for a non-null pointer
> p and try to iounmap it. However, pointer p has not been assigned a
> value at this point, so it may potentially contain any garbage value.
> Fix this by ensuring pointer p is initialized to NULL.
> 
> Fixes: 1a35c88302a3 ("ACPI: APEI: EINJ: Fix kernel test sparse warnings")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Good catch.  Apparently this isn't in my allyesconfig.  It's weird the
zero day bot didn't catch this either.

regards,
dan carpenter


