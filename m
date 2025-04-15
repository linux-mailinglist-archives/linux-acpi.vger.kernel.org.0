Return-Path: <linux-acpi+bounces-13064-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26824A8A95C
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 22:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 636161901C0A
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 20:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47012550B7;
	Tue, 15 Apr 2025 20:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnTpoP/Z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966AE2561B6;
	Tue, 15 Apr 2025 20:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744749043; cv=none; b=cGHiUMSyullk8oBbLsF/vyQMhCM0ANQj10CA0kS66lOu+r45HH679U3mdmLsBD9Y+Ge+80PS7A4cLgZBKmaQbHZEqByfe87sIoEGpX1MEAILykZ71lWpbcQsEhrQX/5ay9ehssJanTeS1d4gWtTWujC5LVRVkD1f4ddRPAmOqKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744749043; c=relaxed/simple;
	bh=wCxBeybE6qJRE3pXHWxqErGRwtA/zocP0Tj2YURCkZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyrREKbzJnlyst3V8+Ri8plLYn0WU3vwjdWkvX3sjm4/3WVzxjXHaQ81UrmQYlj+pFK4VMd59f+G1w1IMPhNxQi16tJxfcRqrGVA/LXdxY7LhGw1KBysleGasmsE61vyVkCHvkeKn65UhZF23MQB2EwVCt/N6vxb+QkWLxg0q58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnTpoP/Z; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2aeada833so11817966b.0;
        Tue, 15 Apr 2025 13:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744749039; x=1745353839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2EnaYYq5VpNpfq3jhDm3c5QMz4PJIrMHZNekW0Qvzd4=;
        b=XnTpoP/Z0mRYteG9fiEU1x8fMKetqEUsJ7W3FyzLN1oEYlz8LxeQCwlcrEqXDYnD1n
         W1Ql92KV4y64kESqvZvkM68i4nz5nGb3tV5WCOe3OQHtxf9WbEoCRywJKbx2h/dQBXww
         TnxQEaLhHuolW6vybrPgm2Ihru0DIU6QktVOVkWI2Tb1kj8GAhVVesG/hUwV5tVfZSLS
         0U2Ae/TkrkVVuI1jd4DFXeUzfNgcgaAwt58dq1QGBBzskNAm+hS1CEdi36d37uWets3g
         luQMYH22fOAS2l85WWCDIp6oWB3CPfiUet1hKli6d/dVSKNE6BTlESRJnhdCUc8V1849
         lJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744749039; x=1745353839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EnaYYq5VpNpfq3jhDm3c5QMz4PJIrMHZNekW0Qvzd4=;
        b=INEUiVsr4BJwpC2DQiOrgqkxG6dvnpQExjhBfNuAsAaHPgO6B+FK1rzNfvd9oXPsuL
         /DYZgbJBCUXS9sjLd0bquvelRwC6VjCO8i7aQfUns4bmGmcc8ElciEnAVU95u8ATpg6+
         FcOi5h1vXPTi9gNoUT7wRUt16GWqdv0pFnN1nzQ78s4oCLiDdwK8R/9XgR9SC8CZNcpN
         pZG6xrQexYVlj3HXGhcFa2ONKWJywrPqzH2zQOAOK6tsooxoQC9mCCbohUR1U5Ab0BGB
         bpkYN0yH9N0TxCTbVM9EDkPjbsb8fGQNmXJKYqoKI9bk3GYykVn2QHJ8QBoPZQzkwOVP
         yTLw==
X-Forwarded-Encrypted: i=1; AJvYcCUP2VqK1LTYflq9VUvxjXCj8iB2nwM6xGnDF466peghJS6T2PtHmZENI6+EhA9/DT16QzrF3v8htT8I@vger.kernel.org, AJvYcCWfxRLWZm+e10OAqEvwjY8hJX0keKJzVVLjybhX9cPEhMxJ5WQfdUPIIFY0axgK42ZiKPUbRHTMD5NXD6zJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyHy5GzJVp7aoxzLGVj6Z9P5RRhuKjxstspS8awsgU85+H5oNHp
	BhCGwGV8PKZ0Pcsl0gOWdLYMQOq4L0uMMe9Dr0jn9VRi8QZWMgRYFXE4L30L4FI=
X-Gm-Gg: ASbGnctpMPPK4Z1JVUru44WdDOQRn1a8tKJT89bighL+T8lNc6xnvN8Iux24/UOgdE7
	ecNHNIDHb+NaLUThkPNESfQTD82TWmVZcHsxKBNIGyPfHqBqCfW1iFyva8AlSMPku2RAq+VGaMF
	gPjyfwtE9WFYYh5mCpZoEtiI8RPkfPrkWg3HSyLeKyPZ7Y9bQVIJe90M5UYQ/S1jvz/HZovoKfj
	97Nex5rsRJRhPUIOIK7VEQ53x4uX/4kr34sJwCfGA+8O81M9cvETpVnnWVIF8nFY7obenOfXdYt
	PDCrcI7DeSfwwh9KmXd7K+O1p1k3wpdnxrh9nOveOCsV
X-Google-Smtp-Source: AGHT+IFpMejbMKxwYVP3ClTbtsxDAvjUr56x/paNPdsUiAiUOxhFmTaY2rFqndunam8jIBSsD9BHVQ==
X-Received: by 2002:a17:907:3f99:b0:aca:aeb4:938e with SMTP id a640c23a62f3a-acb357fd0f8mr75255766b.8.1744749038369;
        Tue, 15 Apr 2025 13:30:38 -0700 (PDT)
Received: from gmail.com ([103.210.134.105])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bed98esm1149894366b.72.2025.04.15.13.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 13:30:38 -0700 (PDT)
Date: Wed, 16 Apr 2025 02:00:26 +0530
From: Brahmajit <brahmajit.xyz@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Robert Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ACPI: Fix building with GCC 15
Message-ID: <gwmtns3c6lxgsxtbit2vwjr64yqlp3wlmvj4p3o6oqi34bng5h@tenldomcival>
References: <20250414161644.30400-1-listout@listout.xyz>
 <20250415190457.351e22a1@pumpkin>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250415190457.351e22a1@pumpkin>

On 15.04.2025 19:04, David Laight wrote:
> 
> Doesn't than generate an 'unknown attribute' error on older compilers?
> 
> Does:
> 	typedef char char_nonstring __attribute__((nonstring));
> 	char_nonstring name[4] = "abcd";
> work?
> 
> If so the attribute could even be applied to 'u8'.
> 
> 	David

David, what if I used the __nonstring attribute from
include/linux/compiler_attributes.h which defines the following

#if __has_attribute(__nonstring__)
# define __nonstring                    __attribute__((__nonstring__))
#else
# define __nonstring
#endif

Which I came across from
https://www.kernel.org/doc/html/latest/process/programming-language.html#attributes
Also the checkpatch.pl scripts suggests using that instead.

I guess this would work from older compilers as well.

-- 
Regards,
listout

