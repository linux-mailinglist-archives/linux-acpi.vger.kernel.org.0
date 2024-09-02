Return-Path: <linux-acpi+bounces-8085-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCD99689E8
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2024 16:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCDE283264
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2024 14:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CDF19E999;
	Mon,  2 Sep 2024 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QA9vBkNd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E8519E977;
	Mon,  2 Sep 2024 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287293; cv=none; b=Fmt6EXPYg0BOd1KIrqMNjyMDFGoJczrBuCGa5SLB7HN/fRt31GtzTihoOxtUDniVp8pYjgR19U1IcBcggsXXa4+KyOnRUzBCMfKDjVSBEbhuGd9OKV5UEObzeGP2Mtt1nbt7QO/AC0vC5TkU8eHAerzSEOMS3E1ApMAGs8I+Pe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287293; c=relaxed/simple;
	bh=ZPnSWwOAvZYxsZdh1NfM/VL04M4Nevd+/cCV1R2LmeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrTV92rJAlHImflhGWSj6QyjBJWPp2IxXaMTR76I2yFvrdB5DmntkaDwi1BHcKJq3DjJzC61azCfAolARNwBpmeXRAYaoijDN+S8jOi7LHQh9xnxulaNTgR0qtn/oOLe+oPYjPMWv5WNlTIDu6blbSKIZ862q2yAqqUYfLxSYJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QA9vBkNd; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7163489149eso2866493a12.1;
        Mon, 02 Sep 2024 07:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725287292; x=1725892092; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5D9ejrd5Z/h0W9FXVKqYlPN2lrRBlYUuxMm5PZhnygE=;
        b=QA9vBkNdEfjOnBp6XYqAznDKDH22TSYuH/2KhGe1W2k1gPx6XBQEjDJNQPGFcttKTI
         2vzyGrsoniPxDu29LEXyy6m3UTLO037Nte+ux9QNozS/BwvzbQwD9TjHH4HME+sz4YO3
         wEf7TJ2JBRvog51dsvMzzH153w4zIB64UmfT0G/Apnzr2MADw0qviuFUiDB7UdCaQRjc
         PaP1LuSGGbutXoIvRBFEbUy8QfWg/OaFF2V7T/cPacMqziualK6+hPj1pulaj9i4ttnh
         7fha/n+zsEVFv4d7xgcLxpYME/fkGABBZklaS/xeGJVDQABy5W/BhkvKHf2jEvrgRSRn
         XqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725287292; x=1725892092;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5D9ejrd5Z/h0W9FXVKqYlPN2lrRBlYUuxMm5PZhnygE=;
        b=fhCWnF9I89BI8/UjE9gCerh36hraDcuO0jS//aXPkIO8sg1Jr5C0cdTTZTU2sROYVO
         BuZt8hTCA2WNVTTfdCvfladqcr+UEa/zPhqQXPap/9nbI44y667ESK+olfO3j2wN0fu6
         Etxo67VvB/oKrkTZSkX0++g7ORCWAebSqWFprxKaIDzJ6SKFsxf75iRPvtHPGX/XbW+W
         TFbMdzC9N37SqclrS2eoJqVBytgmZ0HaLH4AkpJQc1a6dEJGNqnba4DZpEOad0jRX4AG
         NApbJKScWd5iNwAhuItqTqbHlFhA1v/qXBwHwveMAploK6YXwGQ3d9LN/Mz1AYvX2HyW
         3gHw==
X-Forwarded-Encrypted: i=1; AJvYcCUGe7pzN0vfG5K/W21o7dn5OooZSan7FOM0Q8f+597SO5zz7vh5i3MqniXk7dnslERaWzHtJLA6SXE/fy8=@vger.kernel.org, AJvYcCUNibflHzjgIOKWAIozuAG2B6a8PuhJdPMTVXhJsd1h2pJ53dJOQbG8Qdha5jyW6nxB0zhjCzNOuxZq@vger.kernel.org, AJvYcCUyygRXJYaalXHJw5isI6Twk+h7xxvmOD0RlcZaZff1hswfDiriKV+hIySd5CJlde+G2ffoMznzNGERTDxrQTy8Td3NgQ==@vger.kernel.org, AJvYcCXwyVGArbcjGuUOnZlb4geCqcAexL4zmHZNqhJ2uLFn5CLmB8mtPO9wLPG1lH/D14UPx7nlRXTphR+zmDJk@vger.kernel.org
X-Gm-Message-State: AOJu0YwuWfbeA0sXTjJzTfiugo0cxFdFcsumG5r+RujcvX+tGcaobYTV
	gO0iDsQhOdCrqa1VFiMNFoxj6Sxe21NuOzEgoB3OSKrOJzLFedRP
X-Google-Smtp-Source: AGHT+IG9xuQTwx/EcX9g1ocH+WX9E/Rfq4mYvWEqfiVG5vxLUtJSxZyZk9u/rlS6Y6/hL8Ay0zaJoQ==
X-Received: by 2002:a17:902:f60a:b0:205:76d0:563b with SMTP id d9443c01a7336-205840c8e08mr29580445ad.0.1725287291494;
        Mon, 02 Sep 2024 07:28:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2056912c543sm22244905ad.247.2024.09.02.07.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 07:28:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 2 Sep 2024 07:28:09 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Armin Wolf <W_Armin@gmx.de>
Cc: james@equiv.tech, jlee@suse.com, corentin.chary@gmail.com,
	luke@ljones.dev, matan@svgalib.org, coproscefalo@gmail.com,
	hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
	jdelvare@suse.com, rafael@kernel.org, lenb@kernel.org,
	platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] hwmon: (hp-wmi-sensors) Check if WMI event data
 exists
Message-ID: <e90b40e9-b3a5-4228-8f12-b02a77b7789d@roeck-us.net>
References: <20240901031055.3030-1-W_Armin@gmx.de>
 <20240901031055.3030-2-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240901031055.3030-2-W_Armin@gmx.de>

On Sun, Sep 01, 2024 at 05:10:51AM +0200, Armin Wolf wrote:
> The BIOS can choose to return no event data in response to a
> WMI event, so the ACPI object passed to the WMI notify handler
> can be NULL.
> 
> Check for such a situation and ignore the event in such a case.
> 
> Fixes: 23902f98f8d4 ("hwmon: add HP WMI Sensors driver")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Applied.

Thanks,
Guenter

