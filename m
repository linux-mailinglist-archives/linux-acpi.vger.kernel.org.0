Return-Path: <linux-acpi+bounces-20498-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mP4OFL+GcWk1IAAAu9opvQ
	(envelope-from <linux-acpi+bounces-20498-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 03:09:03 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF1160B85
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 03:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF7B18211EB
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 02:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C6334F256;
	Thu, 22 Jan 2026 02:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ek/RC051"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684062E0412
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 02:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769047587; cv=none; b=ItziqK25fj+5LZpK/SVijSmxMv35Uq0C9p3YHQt4RoCjwDaWpdqKSQvTIBgR9A0pLhNyoveiD+IMJgivgDQ5YD6ouHZF0LLef98mny6zjxuAhPn0gIJYsvzbOmcfVsETnzvDTxctS6tt+gIisEZwh2mX0Y9eYahL6DCJsIr7fbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769047587; c=relaxed/simple;
	bh=U+dvsWtDZv50Oz4kWfPVIu70ozgI5yQ4sMPjpZG3iBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqrpDXv7x8NZ04Jj75lZeIJdfS8ex7qjbdmKYJp247PdgLMGhxppfdp31H12qWJvlCS8XaES/8p9N7oWQhMbntBwUsnkMFSqVXZTt0Y1R6R+tUPufd/Q3+05B92RaNjL6f/s/Irvs1D9YzjPHOy8W8OBu6FKuEyIjB86gNfV56U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ek/RC051; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12336f33098so536632c88.0
        for <linux-acpi@vger.kernel.org>; Wed, 21 Jan 2026 18:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769047584; x=1769652384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1aetEum6/U73Ku2v3eVebk2UGZPppByGVWbKAtEnsY=;
        b=ek/RC051nbknkJE9D8rX7RmceR/BjaWh4iisbyieGca43Z9nt66b6Tie7GqxNUp3RM
         gYLBRhJCfzzampawBYAFZJE48eswjVqTI0bu/4GmNKMZ/6xxvBsKl9LWmR5N6tf6FCYx
         EYgZxjuXofgzrqui5lZfBlzYw+IMaAeaMsH5d9cRf4+cjtKMSSNOl/OunOEQvYStFgNk
         eyxVoJaLtvz8Q2GD+SxlZ6j2VEhhXK9a3BKHgIVp5gjTrujtA09FyhUJREQJ0HXrvsBB
         jq2eP3IsOn5QP9SdWAIMpEuB17itH72Ir9xu406779MUHDpfHX19R/SSnWgLaOBhV6v7
         bi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769047584; x=1769652384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q1aetEum6/U73Ku2v3eVebk2UGZPppByGVWbKAtEnsY=;
        b=GeociW+mtfe2I9dfrQ0pictSDUs4gdeouU2agVCr9IIqMHLCjWeyyrY7Zfbkz/EMBp
         gbsuvsIkSScq1/BGkcDLA+lDrNaK0aMsZFBegzhE+Nm34v5OBVCIvEgJt5qWixiAoygd
         x94ownHX0Jq04K2eq3zc6Ni73eq2PNoaVOHTZdro79Ccla18xKCG27K5jGdoqp0QTtV5
         GBDCpcHZOPwv+anL6Yx9nY/JnBb0OtpqnE6nPJ8q80Vdwxywxyn0baE67elZ5CCSmFuS
         qVNoqwF+0xXQNpxuVeZTr/vvaWssRBAhpyoM5M/n8i/9AdkUZiMxdyFLS3UvwmQ7RRWZ
         +65g==
X-Gm-Message-State: AOJu0Yyln7/Zb5pGvpNuGQ8gQsgrszvuF3GHgJeH5nZfajjfX6LrHWkK
	n7GtYpOPc5DAM+U6ENghAndABp4apZjhsbPVpM3br+8WiTdwSN6fqYbIKLwSTA==
X-Gm-Gg: AZuq6aIxnNV/amVs/Kwjt+tw14MgVK7bUbD3yKZ6lJDoOHnrjJVTIzlJGqS28BDD1Rs
	EpJwLm1KDZGU6O8JbPvNtM9EcTGY4AFs+/bx+wAespLgADKQw9D48z/IrU7DphCmMLunSffWpiR
	dwZBu/ctflMcIr0J6Zh5V7r+dFm93gR8kG3WApcClHm6IDhsZzz1+WBmH7Y5ElAfRDZdfs4kYIa
	YY85fRIOA5Rn3+m/BO1MKEuamfoMPqdFN2QrnKNCs9hAc8Bn5nd96H7Mc6xecBwLxcbm9cQ04aB
	w0KR4W6A3VwpisLmb7hf74bwQsBrprgY8xT3C98yEoN49n+K9yI7xQcFcW7MIlLyXqRdaXncoZS
	REo6uhSHCfpMS/2pi5LRRyv/eFWBsaVaGkDYaUDXPVx7MtuTU+JYfd/FxUPmOBLt1l57n6GiGbF
	EfAjdSLFnD6XLQi5iXYNf0D9xC6aYwAzJxkTMyFDq04ynOfHhkkKMR
X-Received: by 2002:a05:7022:6b8b:b0:123:3345:810e with SMTP id a92af1059eb24-1244b35fb92mr12923849c88.31.1769047584138;
        Wed, 21 Jan 2026 18:06:24 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:abb8:3a31:328a:3594])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac58140sm25248140c88.4.2026.01.21.18.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 18:06:23 -0800 (PST)
Date: Wed, 21 Jan 2026 18:06:20 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v1] ACPI: PM: Adjust messages regarding postponed ACPI PM
Message-ID: <fzcmlu2iew2sc7dvooig43c6kkzk74rj5gkseenyvhjesakepu@qn2256b4i6zw>
References: <5969819.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5969819.DvuYhMxLoT@rafael.j.wysocki>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20498-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,linux-acpi@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 0BF1160B85
X-Rspamd-Action: no action

On Tue, Jan 13, 2026 at 02:38:41PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The debug messages added by commit f7599be2bb76 ("ACPI: PM: postpone
> bringing devices to D0 unless we need them") in acpi_subsys_resume_early()
> and acpi_subsys_resume() are not quite accurate because what is postponed
> is not just a transition to D0, but also an adjustment of the device's
> wakeup setting (which may involve disabling a GPE among other things).
> Moreover, these messages don't even mention ACPI.
> 
> Rephrase them and adjust the style to match other messages in device_pm.c.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Makes sense to me.

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/acpi/device_pm.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -1251,7 +1251,7 @@ static int acpi_subsys_resume_early(stru
>  		return 0;
>  
>  	if (pm && !pm->resume_early) {
> -		dev_dbg(dev, "postponing D0 transition to normal resume stage\n");
> +		dev_dbg(dev, "Postponing ACPI PM to normal resume stage\n");
>  		return 0;
>  	}
>  
> @@ -1273,7 +1273,7 @@ static int acpi_subsys_resume(struct dev
>  	int ret = 0;
>  
>  	if (!dev_pm_skip_resume(dev) && pm && !pm->resume_early) {
> -		dev_dbg(dev, "executing postponed D0 transition\n");
> +		dev_dbg(dev, "Applying postponed ACPI PM\n");
>  		ret = acpi_dev_resume(dev);
>  	}
>  

Thanks.

-- 
Dmitry

