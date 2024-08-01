Return-Path: <linux-acpi+bounces-7206-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC26944E06
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Aug 2024 16:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0328B249A3
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Aug 2024 14:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABB11A617D;
	Thu,  1 Aug 2024 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iqt3pYMz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826A81A57DD
	for <linux-acpi@vger.kernel.org>; Thu,  1 Aug 2024 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522518; cv=none; b=GhhQha4sp5vWsZitkFQzaFok258wBe4VznR5Qh+c8TXlos4oVXxQQEUBTPFJEKillZ4oycMpT9rItjrNOo0ANDjqB/g8ZnEP26pNwP1zvDMs+q0iEgTaixvXNvbaZaKmMRN3HnkUSv3z//9QpS7GK9c+TJQSQstpBuDxqxZWQD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522518; c=relaxed/simple;
	bh=arM8Ro9K7nuVuspECh3ENyDIwChnNoKIe9VGYvhA6gI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VHoAyhNOv2YDvDYxUhFRJdpHEAEBlM/14+iICwktSWeY+fPGqJlYw6wliaBaElOj5G96nTpuKsnGsvUE7A11HyOzgbkfppe34ih7hsASv1hq5P84ZvSKqK5ZM5bGKXzAQONMBpmyZIgjwMEBxxIhh7KTgEq+pTup01Xhla5TI34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iqt3pYMz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722522515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ks44jOOs7IUb4zvzyqaWExcTin/vOFoDTeSRZLlKCCg=;
	b=iqt3pYMzK0LsnALHglEUD7gn0NeoSb7wSglEaFzEmSpptRtz7sGeGKMNmWUC14wFMl6Ka2
	IFGPdjRc6h2OxQ2F1kHgRalXDl6udbgOWDjdfP8M8eToXhcpRnC1HrWgRPfuAFEfcXcNvj
	2sWt8ZiMNfUNIkBXlzcnrPvkR7lLzto=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-Sw4vhgjIMpujcAuwOh3vnQ-1; Thu, 01 Aug 2024 10:28:34 -0400
X-MC-Unique: Sw4vhgjIMpujcAuwOh3vnQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52efe4c2261so9403203e87.1
        for <linux-acpi@vger.kernel.org>; Thu, 01 Aug 2024 07:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722522512; x=1723127312;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ks44jOOs7IUb4zvzyqaWExcTin/vOFoDTeSRZLlKCCg=;
        b=wQrpVs6g9oDG+rdfbCV+c+GBeFHiCnmE5PE0nQgIbOP5zdxNGCHlMwm4w/1lWiAf/7
         jNwFd7Tqd5gKx9pqGazZDsObTSYxpUmzJ0l5iISn4QRAIVUWrODwskGMjlqa75CtW584
         hQBLjmCo/kQPM1h/AZ6piKFwISaszy4SwN/z/oqPYRHUJaWGUpdpyVixc+S2lLbkQZZp
         KHEihzfOf1yOdDitY0gME/NTcBaV+1zvVU/hUOFpE/o91acRA+P7qCpdwfA80AYd3uHi
         cYehu9uK1xBZTTEgdOCFZCQ6cYjLu/lOduk3lrMsSGyc7d3aawa6f9xH9mE/Y2HNM8Na
         /QdA==
X-Gm-Message-State: AOJu0YwHxv55YgbhzHKgMbgn72vM+UYnNZcoXxlaZjbPKV9ihSgYEhEm
	rNAd+VwTRt21ApAb8SdUDwhgXrsJHR3ulFDk/aQwOU8UQQbb0EVcC/Rc6JGMiE/C96n6VAQCfUi
	uwhBfqrPgFF2cFgTnV7Nvz+/2hBiM3Fw2xg3DvL7Fk/U+AMERyJP5xbXmfvc=
X-Received: by 2002:a05:6512:2387:b0:52c:d5ac:d42 with SMTP id 2adb3069b0e04-530bb373067mr65962e87.9.1722522512551;
        Thu, 01 Aug 2024 07:28:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzzdyLbl1W8pm0/Ez33Fzvo6k7SoGibqkn8s2HgvC6eEe1Hp/DwngwV0qza3H0lA/U6gRUaA==
X-Received: by 2002:a05:6512:2387:b0:52c:d5ac:d42 with SMTP id 2adb3069b0e04-530bb373067mr65950e87.9.1722522511979;
        Thu, 01 Aug 2024 07:28:31 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab50cbfsm903350266b.47.2024.08.01.07.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 07:28:31 -0700 (PDT)
Message-ID: <c0e5414a-ec7b-44e3-980c-e71889150767@redhat.com>
Date: Thu, 1 Aug 2024 16:28:31 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "EC: Install address space handler at the namespace root" causing
 issues for some users
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>
References: <1f76b7e2-1928-4598-8037-28a1785c2d13@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <1f76b7e2-1928-4598-8037-28a1785c2d13@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/29/24 1:15 PM, Hans de Goede wrote:
> Hi Rafael,
> 
> There are 2 bug reports:
> 
> 1. Brightness up/down key-presses no longer working on LG laptop (acpi-video related):
> https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org/thread/V2KWAGZIAX4TOWPCH6A6FSIT66PR3KMZ/

I have filed:

https://bugzilla.redhat.com/show_bug.cgi?id=2302253

to track this now and an acpidump of the troublesome LG laptop
is attached there. I have also requested dmesg output of
a non working kernel to be attached there.

As a reminder this is the bug where it has been confirmed that
reverting "EC: Install address space handler at the namespace root"
helps, with the caveat that there is a Thunderbolt related IRQ
storm on the ACPI event IRQ after the revert ...

Regards,

Hans




