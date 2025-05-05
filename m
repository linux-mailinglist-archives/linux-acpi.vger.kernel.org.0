Return-Path: <linux-acpi+bounces-13451-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA79AA94CF
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 15:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84E301899FF0
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 13:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A27A191F8C;
	Mon,  5 May 2025 13:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EE5nxS+Q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC022C859
	for <linux-acpi@vger.kernel.org>; Mon,  5 May 2025 13:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746452957; cv=none; b=mfcOr2TQlCQS1D/IZ393SK/sLzc+CawMgBYbcg/3zkZdOHYAlLC00MGljyszzPn/mdouLxZE+dq/few1RdMMieZj0qEOi+vnCDmD4IVoEM+fpSY3ktqJt7FQ4MDM08fGCCpz2HRuj8evTMvNM0NlTx6wL35NWGwBXoh4ufArPpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746452957; c=relaxed/simple;
	bh=PDdS5fAJqi8PcejufO5Pd6xIuj0adNqB54QOk5mfbR8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=INTeLK8Exd4ypwcC1SPwIGo8hw43zW72LlAw+Z4s9l1ldCcHLsKxdx77oKm0nZMPkumfzNIDkWdm8d98+HHZwrXgv4S+It22996fZq1gaAdp6Oqc8MMUxMfr1iRDoJvFJ0c2BmKfwnbUlYXPFSsb7ISdqZ483K5EyrHYTRpGw8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EE5nxS+Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746452954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ob+qs8HMqf9ejJq0jFehTAErEqZGMs/1HrQN+kJELKo=;
	b=EE5nxS+Q21+KaE7jIEO484kbSaSZQWx2pDORjd4cDjhMPhpBlmHdVWAzmDbiSITifHsh9V
	QrlesvL7A6/+n+3cHcHQgV0T/DU5EJUTz1hGBVlt/ZVnnvszqvt9/ueoPpxD82h9rHeMdh
	kYW+OMTWs9zDplxFHxBjMX+Kx0cyhcw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-k58JYQyMOh-NWzKf7dAbbQ-1; Mon, 05 May 2025 09:49:13 -0400
X-MC-Unique: k58JYQyMOh-NWzKf7dAbbQ-1
X-Mimecast-MFC-AGG-ID: k58JYQyMOh-NWzKf7dAbbQ_1746452952
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac28a2c7c48so404422266b.3
        for <linux-acpi@vger.kernel.org>; Mon, 05 May 2025 06:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746452951; x=1747057751;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ob+qs8HMqf9ejJq0jFehTAErEqZGMs/1HrQN+kJELKo=;
        b=tV78kcBxPOH8D/xe/EcaFYaXihC7XmHiPgBIiYiax4cC3t1ITX8EBwQy6HnaKrIEaF
         aseyHBajOLdpgW29IXXOSoiGBunWNFVwcg/xStlUPiBwiX46k42sPxc0YR22HgkGP4Ck
         2YurDvTOO0AEBhbmKiJr8y9IY8z+NAG701brzlhgNBH1Cf48DXI4BTnqUugXfjBUIDAA
         d3MC9DhHERJvQa98K3jbDP7fsUz8ZRV/A46Yz2VooQu+Xw6qAmAGxYIVin37xF8ifm5o
         NLabXqIDcEqJSZ/J6ebJo0A/p3lSbMguoRSGpDMb83TXLGf9VlX9Nu/HVQdXZAZFV5ef
         azqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVHuRbQGnkAOTwTqAXHiUkP64PIC+hGOJmpOzxjCFvvfGVibvEpOKZF3nK3IbJVwplyhLPoUEtA+Qi@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz7hf1osQK5kPO81w4xVEE9RPOR3AVZa8h4z05a/Ibkcqh9iOp
	nL3RjHOqWnNh+gnT6gzSmftnVqn0u3XzvEMxsI9hK6FAbVsbYIo29LD0tRJfawX4X6V7eQUHb3m
	1ix3nsMCGDMxekrcecryPleWW8DXAs4r0W1z/QJ1wu/WF6qW0ScIe7/mcPvXZi8eTnAmovQ==
X-Gm-Gg: ASbGncvYncX46rmXRT/Wq+jzzde4mP+vzgpJywfKrtUV5POFDb7qHEATB0dj2B+P8br
	SAHVICxOptL0Ba2kHiPQciF3f5mRVHCtL0/VI+kccSfGB4VGwbwXMgR9vc9AV5V5dzybxnf4Y8w
	TfSHXvQ0Ih8vshY4bHXt371GD+z71W33aNPUWQuVe+dww/cjD/aHkZTGF97wHOsjBohn5qFT//g
	SXU/njjwHfP89e/dhQpipy5UiWktPOQTZi0NtN5oUpK7FrRJwzybQcoma7ZrLLDbWty35cDiyYi
	8htyZExbFyOAeVQ026qib1xgCFmsdTsyo9motv0JBlVK+6NCKSI2Gs8STJMydQhXrZYo8NVTPRE
	37qEEaIZC/VWPgbZzTesJ1LP6m377MO5vq3Z9wL3qU+oPWQkOXl1K2yDfm7xZgA==
X-Received: by 2002:a17:907:3e05:b0:acb:33c6:5c71 with SMTP id a640c23a62f3a-ad1a49c3349mr739054266b.29.1746452951417;
        Mon, 05 May 2025 06:49:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2/er0nnS3bq3BAhH6tbXajalx7PNeaNBxCuzeBHhpUE2GZNvpXKoknjUzLYfsJFUuOfn4Qw==
X-Received: by 2002:a17:907:3e05:b0:acb:33c6:5c71 with SMTP id a640c23a62f3a-ad1a49c3349mr739051666b.29.1746452951002;
        Mon, 05 May 2025 06:49:11 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1894bf973sm500251166b.99.2025.05.05.06.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 06:49:10 -0700 (PDT)
Message-ID: <8d52bffe-9d16-481e-a997-837988f2ebe5@redhat.com>
Date: Mon, 5 May 2025 15:49:09 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, nl
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-acpi <linux-acpi@vger.kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
Subject: ACPI power-resources not turned off after failure of device-driver's
 runtime resume function?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Rafael,

While testing error handling in the atomisp driver, deliberately
making a camera-sensor driver not work by using gpioset to disable
a regulator, I noticed the following:

The ACPI device pm_domain runtime_resume function looks like this:

int acpi_subsys_runtime_resume(struct device *dev)
{
        int ret = acpi_dev_resume(dev);

        return ret ? ret : pm_generic_runtime_resume(dev);
}

Combined with the runtime_error flag blocking any futher
runtime-pm get() / put() calls (making them fail with -EINVAL)
this means that if the device's driver runtime resume
function called by pm_generic_runtime_resume() fails,
nothing will undo the acpi_dev_resume() leaving e.g.
ACPI power-resouces associated with dev in the on state.

I guess a possible fix would be to change
acpi_subsys_runtime_resume() to e.g.:

int acpi_subsys_runtime_resume(struct device *dev)
{
        int ret;

	ret = acpi_dev_resume(dev);
	if (ret)
		return ret;
		
	ret = pm_generic_runtime_resume(dev);
	if (ret)
		acpi_dev_suspend(dev);

        return ret;
}

but I'm not sure if this is the correct fix ?

Or is the assumption simply that if things go wrong it
is best to just leave everything as it us to avoid making
things worse? Similar to how this will result in the
runtime_error flag getting set disallowing further
runtime-pm get()/put() calls ?

###

About the runtime_error flag I also noticed that if I enable
the deliberately disabled regulator after first testing
the error handling then subsequent attempts to stream from
the sensor will fail because pm_runtime_get_sync() fails
with -EINVAL due to the runtime_error flag. I guess this is
deliberate and drivers can then e.g. queue a workqueue item
to do a full reset and then clear the runtime_error after that?

And it seems that the runtime-error also needs to be cleared
followed by a successful pm-runtime get() + put() pair 
to release the ACPI power-resources.

So I guess that drivers where errors may be intermittent and
the runtime-resume should be retried the next time, something
like this should be used: ? 

        ret = pm_runtime_resume_and_get(&sensor->client->dev);
        if (ret) {
                /* clear runtime error to retry resume the next time */
                pm_runtime_set_suspended(&sensor->client->dev);
                return ret;
        }

Regards,

Hans




