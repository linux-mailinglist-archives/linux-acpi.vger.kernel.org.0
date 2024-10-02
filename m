Return-Path: <linux-acpi+bounces-8533-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1540F98D90A
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Oct 2024 16:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FDF31C22D9B
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Oct 2024 14:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDED1D173A;
	Wed,  2 Oct 2024 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhUpyPca"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2A11D0DF4
	for <linux-acpi@vger.kernel.org>; Wed,  2 Oct 2024 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877759; cv=none; b=SLUfosyKrDmnzu2LS47Ux4Bw3LzZ7fKEx8IXP8L2ozvZI6Jhlbc6X7HFhFjy5yJF7KEkOuoRYdPjdYWSi6UKQCTzS35p/bKtl3aS+PYoLz7ZpEbcaCKiBvPBK9axb/Kh3fSVrPmKzoo1z9qr0js3RbJxYVUVF8CD6vgj/BPWSeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877759; c=relaxed/simple;
	bh=iJLxbS+yCNUuo/C4ic9QV/YCOLXIQ/5CXKvr5tSj3oI=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:References:To:
	 From:In-Reply-To; b=fdVO7XW2+XoWzY06gVu87orR8YY4nv4A36LjqKmfSce11KNd9z/j9/IOFO/USXojLw7+v7rsrafA/fUPw7bLQKugXi5gsqhs9GKrKPZW/Ma1+1AUt5XDv7LWRb52NTlaDH1yYgzIriGrnyLVpR7EenNvC2tMk7PSDmshR3BqpUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhUpyPca; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a2759a1b71so33793125ab.0
        for <linux-acpi@vger.kernel.org>; Wed, 02 Oct 2024 07:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727877757; x=1728482557; darn=vger.kernel.org;
        h=in-reply-to:from:to:content-language:references:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KlQawy3t0iZD53rh6kwouw4EXUlmdf7CpLOESzQ/uR8=;
        b=mhUpyPcaW8gg9TSw/RrUDgRH7i2mnyOi0SYniel7Nvv79OJycj2En+zt4Iq2ICQBo2
         zPebcScsXipHA92MtFmX3Zo+lYhs8T3sRMu9dT4M/TSiFJhSFBUjFy9B6adUd8gn7AOl
         mdXDMuy40F+p9Yf+vY/oUh9mpdtEHRysHJChrsNDrbnP8gYT738SPCH6bLI0oGoXYJQ8
         +hQGXyfC5z51V9/qHnSX0tIiCV+6+Bc9iIUN6dvT3USpxfjJipDb4Pe4GxHlz/QOKCQP
         sTZniRXC0nfBIr0aPtTrDM/EFuHK4J/CVzXyXfaASom9TTednavF7AmaSMdwRiLAmtsz
         evdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727877757; x=1728482557;
        h=in-reply-to:from:to:content-language:references:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KlQawy3t0iZD53rh6kwouw4EXUlmdf7CpLOESzQ/uR8=;
        b=Z80PzTvO+EuOTxae/1WXUzw1BZ597Et8ymMRNpI2rn7kCuc2Ire1UHLUrfvmy2OIoo
         zTP9Hw0EjAaeoMCr2NDhadM4hC9p3DctaRIcpV+U6CkA7+O2jnWju6XygwJHdknAVcmC
         tyge9oLpBGb/TLfPMQ7RK8PnSu4KT/MyQZNsqCIalhwk+gvpQ6M//JOu6YQ0hjSXiO44
         2t+mlKRXUfVSQKyE2gDNRz2oOsCTp1zVsYfYv3fcUqyBwijml06J0qRAQaubO6hWtn/G
         oOf9GTbZSahk9FGTVAgRPSeRe99kIxWSlIX8tzPbeo0qGBiPVL1XvumxIgCkIV18IlhC
         b5WA==
X-Gm-Message-State: AOJu0Yw2wKkS/GKvzFaeJ/mdQ8UdX1AkVXGrzwCl9TmiwRrf+y2EXUeK
	dQEy3Mead8g26b3Qf+y661ghQs+Gfy2lUatgeaj4B/v6Q9STbN0ItKPB+8gB
X-Google-Smtp-Source: AGHT+IF+DLOgNQyxU/Bunm40obfd+ixw100W/DHcgI89VxusQOhQiAyewY2gywPD22qIBW0GRRn/kA==
X-Received: by 2002:a92:b741:0:b0:3a3:68bc:a17a with SMTP id e9e14a558f8ab-3a368bca2b5mr13277965ab.11.1727877756439;
        Wed, 02 Oct 2024 07:02:36 -0700 (PDT)
Received: from [192.168.0.24] ([173.27.86.46])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a344d6059bsm36684955ab.6.2024.10.02.07.02.35
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 07:02:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------IabLcf6ohXGbmcKq0V2pyy3G"
Message-ID: <a9d469db-92c3-44e8-b9c4-be57bdaf60c9@gmail.com>
Date: Wed, 2 Oct 2024 07:02:33 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Fwd: HTML message rejected: Fwd: Fwd:
 https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.10.12&id=5a04cc4450f4793760b1a7ced8f05f0f5f64e0a9
References: <1727876989-30351-mlmmj-2e376003@vger.kernel.org>
Content-Language: en-US
To: linux-acpi@vger.kernel.org
From: Al Heynneman <heynnema@gmail.com>
In-Reply-To: <1727876989-30351-mlmmj-2e376003@vger.kernel.org>
X-Forwarded-Message-Id: <1727876989-30351-mlmmj-2e376003@vger.kernel.org>

This is a multi-part message in MIME format.
--------------IabLcf6ohXGbmcKq0V2pyy3G
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

linux-acpi,

Resend as text...


-------- Forwarded Message --------
Subject: 	HTML message rejected: Fwd: Fwd: 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.10.12&id=5a04cc4450f4793760b1a7ced8f05f0f5f64e0a9 

Date: 	Wed, 02 Oct 2024 13:49:49 +0000
From: 	linux-acpi+owner@vger.kernel.org
To: 	heynnema@gmail.com



Greetings!

This is the mlmmj program managing the <linux-acpi@vger.kernel.org> mailing
list.

Your message to <linux-acpi@vger.kernel.org> was not delivered to the list
because it contained a HTML part. Only text/plain messages are allowed on
this list.

Please configure your mail client to only send plain text mail.

For your reference, the rejected message follows below.


-- 
*Al Heynneman*
heynnema@gmail.com
--------------IabLcf6ohXGbmcKq0V2pyy3G
Content-Type: message/rfc822; name="message.eml"
Content-Disposition: attachment; filename="message.eml"
Content-Transfer-Encoding: 7bit

X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A9417B421
	for <linux-acpi@vger.kernel.org>; Wed,  2 Oct 2024 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876989; cv=none; b=k+R8EZam0BHR0WcD+V3rxKcS9hJnv0ItHlphkt8vXKm5BhOBn3flScTkvgkGImHEu8YzAet9ZCIBF0o5JBK3nB7U5hYVPP3xbq9TDTofAZEtlUbWOgOjpQWU0jl0glLfg+MFqvZ8aS1D9jk9hKqDFvq2pIKPfrGfnbuJEUMufXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876989; c=relaxed/simple;
	bh=fyesRFWs14AgHUERhtAN1tvYFIFYzPjDpfHVek7/Bhk=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:References:To:
	 Cc:From:In-Reply-To; b=mM44DK1WwWGniLeMxLSZ0PUZvC5kOpIsjxEBVA6S3zHGec9Ag3apMEUr7YEM+VV6W7t5ZbINsQcrdTe7JQvzgUz4hSx1mCUOfN381xspTckaUpIdz1BUg2te1un6LArxdM+8j3tLQkWZu1wfiePr8lyPad4XfIoOfk/He6RPxoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVqGZodC; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVqGZodC"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-82cdb749598so381353839f.1
        for <linux-acpi@vger.kernel.org>; Wed, 02 Oct 2024 06:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727876987; x=1728481787; darn=vger.kernel.org;
        h=in-reply-to:from:cc:to:references:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Z1LcTgnbe20QTvSesocB73ckVqTMFr7uXL5Z6s3Vro=;
        b=nVqGZodCjkmmTFK9HV1Um5Qz8SyqjZRraTR7eWZiO5VjNjG/rUuhq7uejXru6fiC+d
         BzJ8vyrk7nxpY+U1bt62UFTAv8D/oqYr9nBw0xazSoPAhAhdWZVEY4cUmbT+BnxpXeY1
         P3PvTv/b9Ph16u552wKejhEnJKP6umPpJqPEpkq3nhNBl3eOlf7iH23Zr66dfmi1P3GB
         C7YD5dAtEZH7Gc+uiedUUYRJPObzbdinL5RAb3EcndY4VMOFIdYFFKWemSw4mz9M7hrX
         XaX8FJMdx7g4P/WAwNSP9PkBwLaQ8iKxhwrl2BIinyms/BDSHgLVV/wyBba+7OcoZbZH
         k9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727876987; x=1728481787;
        h=in-reply-to:from:cc:to:references:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6Z1LcTgnbe20QTvSesocB73ckVqTMFr7uXL5Z6s3Vro=;
        b=k97FuvR8IDh8cqRPTNxH/aBuNGWgndi+FwdV2m53i0rpezb4jGyldWU4j1laf0NLBy
         CR4aIViMbu2YQdNyy0uT12yssjJNB0DVzvHSeDL5Ps1ppB5QB8bAssQwC/jMmz9m0ktz
         c1YLd2adDfU1Uk9FKvQIatDMtdPr89kOk57GGHH0FZneQ1PSyrfId+rdpTt0MOsXM+9r
         nABi+bL7VQD6QC5l3rUyBrly8qA4AVPgTjwrV98KppHGgNP+kDS00SDr/ZICHFmeemTa
         Jgp8TZEbws38os9k9/JILFLHZCK8XtkSAVRw/gGfNOHGsUUeVLXSt+EZranp+79nlSIv
         tfkQ==
X-Gm-Message-State: AOJu0Yzdsh9pC49mLvYw1zM19mxcXMPlrRWtNLOY+9/EX4E+TZKQrfN6
	iG7odsDGe0901I5pcxoCdASJedjNyrovRtF0nONYiPm4lCDP/7haC9u3XtfL
X-Google-Smtp-Source: AGHT+IEB+x09Lne2b6WsjDzovqWTCrIKOaGTHL1bM4eRoR4hNhU6mqGIBAvJ8FHfZmyh2nDo3AXj7A==
X-Received: by 2002:a05:6602:1509:b0:82c:bdec:1c0e with SMTP id ca18e2360f4ac-834d83b644cmr295659739f.2.1727876986707;
        Wed, 02 Oct 2024 06:49:46 -0700 (PDT)
Received: from [192.168.0.24] ([173.27.86.46])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d8888c2c51sm3117175173.102.2024.10.02.06.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 06:49:46 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------kosMKYyUL7FEz0v4Ge0L0z50"
Message-ID: <df516fb0-034e-430d-8173-b3fe844fa440@gmail.com>
Date: Wed, 2 Oct 2024 06:49:44 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Fwd: Fwd:
 https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.10.12&id=5a04cc4450f4793760b1a7ced8f05f0f5f64e0a9
Content-Language: en-US
References: <ded31d34-8c7b-4164-9d53-2c47b6b6e28d@intel.com>
To: linux-acpi@vger.kernel.org
Cc: hdegoede@redhat.com, pbmerland@gmail.com
From: Al Heynneman <heynnema@gmail.com>
In-Reply-To: <ded31d34-8c7b-4164-9d53-2c47b6b6e28d@intel.com>
X-Forwarded-Message-Id: <ded31d34-8c7b-4164-9d53-2c47b6b6e28d@intel.com>

This is a multi-part message in MIME format.
--------------kosMKYyUL7FEz0v4Ge0L0z50
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

linux-acpi,

Please see my bug report at:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2067498

Cheers, Al


-------- Forwarded Message --------
Subject: 	Re: Fwd: 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.10.12&id=5a04cc4450f4793760b1a7ced8f05f0f5f64e0a9 

Date: 	Wed, 2 Oct 2024 15:36:19 +0200
From: 	Wysocki, Rafael J <rafael.j.wysocki@intel.com>
To: 	Al Heynneman <heynnema@gmail.com>
CC: 	gregkh@linuxfoundation.org



Hi,

On 10/2/2024 3:06 PM, Al Heynneman wrote:
> Rafael, Greg,
>
>
> -------- Forwarded Message --------
> Subject: 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.10.12&id=5a04cc4450f4793760b1a7ced8f05f0f5f64e0a9 
>
> Date: Wed, 2 Oct 2024 06:01:16 -0700
> From: Al Heynneman <heynnema@gmail.com>
> To: hdegoede@redhat.com, gregkh@linuxfoundation.org
> CC: pbmerland@gmail.com
>
>
>
Please send your report to linux-acpi@vger.kernel.org with a CC to Hans.

This way it is less likely to get missed.

Thanks!



> Hans, Greg,
>
> re: 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.10.12&id=5a04cc4450f4793760b1a7ced8f05f0f5f64e0a9
>
> The Dell Inspiron 7700 is also effected by this problem. Please see my 
> bug report:
>
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2067498
>
> I don't know how to check my DSDT to see if my values are different 
> than this:
>
> In DSDT this uart port will be defined as: Name (_HID, "DELL0501") 
> Name (_CID, EisaId ("PNP0501")
>
> This may have to change, also, as my product name is "Inspiron 7700 AIO"
>
> + DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> + DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 7760 AIO"),
>
> Cheers, Al
> -- *Al Heynneman*
> heynnema@gmail.com
>
> -- *Al Heynneman*
> heynnema@gmail.com

-- 
*Al Heynneman*
heynnema@gmail.com
--------------kosMKYyUL7FEz0v4Ge0L0z50
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    linux-acpi,<br>
    <br>
    Please see my bug report at:<br>
    <br>
    <a class="moz-txt-link-freetext" href="https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2067498">https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2067498</a><br>
    <br>
    Cheers, Al<br>
    <div class="moz-forward-container"><br>
      <br>
      -------- Forwarded Message --------
      <table class="moz-email-headers-table" cellspacing="0"
        cellpadding="0" border="0">
        <tbody>
          <tr>
            <th valign="BASELINE" nowrap="nowrap" align="RIGHT">Subject:
            </th>
            <td>Re: Fwd:
<a class="moz-txt-link-freetext" href="https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.10.12&amp;id=5a04cc4450f4793760b1a7ced8f05f0f5f64e0a9">https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.10.12&amp;id=5a04cc4450f4793760b1a7ced8f05f0f5f64e0a9</a></td>
          </tr>
          <tr>
            <th valign="BASELINE" nowrap="nowrap" align="RIGHT">Date: </th>
            <td>Wed, 2 Oct 2024 15:36:19 +0200</td>
          </tr>
          <tr>
            <th valign="BASELINE" nowrap="nowrap" align="RIGHT">From: </th>
            <td>Wysocki, Rafael J <a class="moz-txt-link-rfc2396E" href="mailto:rafael.j.wysocki@intel.com">&lt;rafael.j.wysocki@intel.com&gt;</a></td>
          </tr>
          <tr>
            <th valign="BASELINE" nowrap="nowrap" align="RIGHT">To: </th>
            <td>Al Heynneman <a class="moz-txt-link-rfc2396E" href="mailto:heynnema@gmail.com">&lt;heynnema@gmail.com&gt;</a></td>
          </tr>
          <tr>
            <th valign="BASELINE" nowrap="nowrap" align="RIGHT">CC: </th>
            <td><a class="moz-txt-link-abbreviated" href="mailto:gregkh@linuxfoundation.org">gregkh@linuxfoundation.org</a></td>
          </tr>
        </tbody>
      </table>
      <br>
      <br>
      Hi,<br>
      <br>
      On 10/2/2024 3:06 PM, Al Heynneman wrote:<br>
      <blockquote type="cite">Rafael, Greg,<br>
        <br>
        <br>
        -------- Forwarded Message --------<br>
        Subject:
<a class="moz-txt-link-freetext" href="https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.10.12&amp;id=5a04cc4450f4793760b1a7ced8f05f0f5f64e0a9">https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.10.12&amp;id=5a04cc4450f4793760b1a7ced8f05f0f5f64e0a9</a>
        <br>
        Date: Wed, 2 Oct 2024 06:01:16 -0700<br>
        From: Al Heynneman <a class="moz-txt-link-rfc2396E" href="mailto:heynnema@gmail.com">&lt;heynnema@gmail.com&gt;</a><br>
        To: <a class="moz-txt-link-abbreviated" href="mailto:hdegoede@redhat.com">hdegoede@redhat.com</a>, <a class="moz-txt-link-abbreviated" href="mailto:gregkh@linuxfoundation.org">gregkh@linuxfoundation.org</a><br>
        CC: <a class="moz-txt-link-abbreviated" href="mailto:pbmerland@gmail.com">pbmerland@gmail.com</a><br>
        <br>
        <br>
        <br>
      </blockquote>
      Please send your report to <a class="moz-txt-link-abbreviated" href="mailto:linux-acpi@vger.kernel.org">linux-acpi@vger.kernel.org</a> with a CC to
      Hans.<br>
      <br>
      This way it is less likely to get missed.<br>
      <br>
      Thanks!<br>
      <br>
      <br>
      <br>
      <blockquote type="cite">Hans, Greg,<br>
        <br>
        re:
<a class="moz-txt-link-freetext" href="https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.10.12&amp;id=5a04cc4450f4793760b1a7ced8f05f0f5f64e0a9">https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.10.12&amp;id=5a04cc4450f4793760b1a7ced8f05f0f5f64e0a9</a><br>
        <br>
        The Dell Inspiron 7700 is also effected by this problem. Please
        see my bug report:<br>
        <br>
        <a class="moz-txt-link-freetext" href="https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2067498">https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2067498</a><br>
        <br>
        I don't know how to check my DSDT to see if my values are
        different than this:<br>
        <br>
        In DSDT this uart port will be defined as: Name (_HID,
        "DELL0501") Name (_CID, EisaId ("PNP0501")<br>
        <br>
        This may have to change, also, as my product name is "Inspiron
        7700 AIO"<br>
        <br>
        + DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),<br>
        + DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 7760 AIO"),<br>
        <br>
        Cheers, Al<br>
        -- *Al Heynneman*<br>
        <a class="moz-txt-link-abbreviated" href="mailto:heynnema@gmail.com">heynnema@gmail.com</a><br>
        <br>
        -- *Al Heynneman*<br>
        <a class="moz-txt-link-abbreviated" href="mailto:heynnema@gmail.com">heynnema@gmail.com</a><br>
      </blockquote>
    </div>
    <br>
    <div class="moz-signature">-- <br>
      <b>Al Heynneman</b><br>
      <a class="moz-txt-link-abbreviated" href="mailto:heynnema@gmail.com">heynnema@gmail.com</a><br>
    </div>
  </body>
</html>

--------------kosMKYyUL7FEz0v4Ge0L0z50--

--------------IabLcf6ohXGbmcKq0V2pyy3G--

