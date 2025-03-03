Return-Path: <linux-acpi+bounces-11739-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03F0A4C8F8
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 18:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF32E7A7FF9
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 17:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE49266182;
	Mon,  3 Mar 2025 16:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OJOIaP0V"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD66526561E
	for <linux-acpi@vger.kernel.org>; Mon,  3 Mar 2025 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020939; cv=none; b=TllexIeeZBmveXY+ou3O2sRGW9NXeaY8T5V6qOCOK6bDi4LkLYteoO7aQ0rl7l/LINUIG/QmyuCqnN264+Zam9PsJwGuUY+UZCqWInMR+RMMZYSBP0pUg7cht4cSNK2N/NYc5VGzHN6/SklY9fCgaqz5Kkza9fvwiEt0ua7iUxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020939; c=relaxed/simple;
	bh=UH4NlzYBkkWgbKnndkALjc2/BnPKdAhK1NZQa5X3WkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2qLxsJdbVzug1p9a7JR1zXrUGZc2W2gs6kp1quzAjOzenmsquZt5S57xbdphQn+LbV/MgCy6iXkDs4byGmOo6gJtaOzLIStrSMSf3Dw3tZLyALNtjays6pGqkZU0HjrRVn9u/axYLB7qCfeDSp44z4eOua8SdXTKCS1KeUT0ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OJOIaP0V; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-474fba180cfso72561cf.3
        for <linux-acpi@vger.kernel.org>; Mon, 03 Mar 2025 08:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741020937; x=1741625737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YJqDa+ZdsMQ9ydSfsBA3qoRWbBlsc9jKdUugmc9+LO4=;
        b=OJOIaP0Vxe+u3W1PRLYO3rpVYvJuxpJB+ajjqUENSzTHaKhQY/79ZSK60XQ/Ym5Iwr
         uv7jQ5EtJNoQM8qIX+d4ctGDZgF6DUdlSpIHqtuuYF9sdOEMOaDwNuoDtF6zlK4UNOQb
         onhd3/UeANnsLKxfjXp9PHUuv1T+0O8VVSxbDlX1w1Xqv/OY3UgDYNTnuhmdu9tZta8K
         bB1oyhYeOafYttdLjsKm6bO1rTDMSSWtfdGb6hTTc5dp4RJ72sbU6K5AMZ6rlH04iXQy
         hOVdcGkZGNecpwVkPDSV439RqyEmbuQzMmHKZ6W/JvkiPeCYDiHAbdXSRLtG1Uh/6tYk
         VOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741020937; x=1741625737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJqDa+ZdsMQ9ydSfsBA3qoRWbBlsc9jKdUugmc9+LO4=;
        b=md3y0URhjFgqMXMYtHVA2NvH/FpyrFsG+zFUnSYhHilfM0X/In7UGA2a9qsNQWE0c1
         hCX24x3xf8fHwexbkKa7KVZP77mg7hIA/IMboVIAomLR9gLilYhxW1N7yVB0jmPXQw7B
         kwaiZQ7kXLhACK3NFFQ+KD2TwQXC4gvd2irWGNe6WCtjZCLpyk026gECkV+3yRVxHhkK
         osMIcGnAQTNVqtfnKHj5z/f3b8poa3CGDOXal8s5sdsxGFbSSLcC7ho/spluwtpogC2X
         S8JONQ5OVxXq4TN3DddHb6ml6wya3+nre/oJRflPlq9csmui4yDQO3L8rfFrR65O81ip
         xRZg==
X-Forwarded-Encrypted: i=1; AJvYcCVdxS27fdrMaGt0kcmT6Fg6zDqagvWCYLid/SDSi8+H8oc9LIEB7rWjGra5sd7SbEHPjQUyqSgH6UBx@vger.kernel.org
X-Gm-Message-State: AOJu0YzXSPm3VVqR/fXR4w0hDteSqucVB8xLo8Nju2hL9Ibpnrq71uXS
	h+ZS3Cm8SNaFFUZOMo18nnc63HQLRA7pE3RpYMFI2ZwpZ+Mn09F1uvXj1eTbKto=
X-Gm-Gg: ASbGncv0sa7SKxKYAXaOqXeX8EJLF3evuEjpiptqMgaoOeKpfzs/XMsf975W22Tsedn
	aBfvxwfsClrjAfnZGNe6S/As5dbSl/0GTsR+0dy+mRa17CWZZbMBOixm9WOtO0yMVPyuNO85RuB
	vC+K7Ly/OSrt8SJZPqs66DEMcYHI/2siDcUbtDGIjiVvftuMbXCmaaVcFkyoAjXcrP8Jd8PjrMC
	qEqmvxj+c5vLfVE+J6dBndrIZOFKhAbDkXYyUzpZkt+ayckBOY65zBV1Raxc7zNqfTwcy2c6/uW
	DeTbKPmxKV37YPYTOGBA7Ar3Ge2CtJNFpABlz0Pxkx7l4+gmb763vdkVLSHbOLv0NI2RgUqhg/M
	DvquyJQRJizfAauUxGg==
X-Google-Smtp-Source: AGHT+IG3i30Vik/hq07e5CV5t54ZLHhq9hBAl2BnifWRWrXSNf/6v99OiWRFpkGkprdx8XpLFqILeA==
X-Received: by 2002:a05:622a:22a4:b0:474:d12f:2f3f with SMTP id d75a77b69052e-474d12f3287mr114169491cf.51.1741020936660;
        Mon, 03 Mar 2025 08:55:36 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474dc59d291sm20118051cf.40.2025.03.03.08.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:55:36 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tp94p-00000000olC-0YQE;
	Mon, 03 Mar 2025 12:55:35 -0400
Date: Mon, 3 Mar 2025 12:55:35 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Stuart Yoder <stuart.yoder@arm.com>, linux-integrity@vger.kernel.org,
	peterhuewe@gmx.de, sudeep.holla@arm.com, rafael@kernel.org,
	lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] Add support for the TPM FF-A start method
Message-ID: <20250303165535.GT5011@ziepe.ca>
References: <20250217224946.113951-1-stuart.yoder@arm.com>
 <Z8SypwnbJR4g8Bho@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8SypwnbJR4g8Bho@kernel.org>

On Sun, Mar 02, 2025 at 09:33:59PM +0200, Jarkko Sakkinen wrote:
> WARNING: line length of 102 exceeds 100 columns
> #764: FILE: drivers/char/tpm/tpm_crb.c:821:
> +                               FW_BUG "TPM2 ACPI table has wrong size %u for start method type %d\n",

Just ignore that, it is an error in checkpatch. Strings are required to
be long. I suspect FW_BUG confused it.

Jason

