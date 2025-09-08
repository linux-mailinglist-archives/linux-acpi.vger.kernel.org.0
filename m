Return-Path: <linux-acpi+bounces-16450-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D2AB48A87
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 12:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5191B25749
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 10:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E347B1F4191;
	Mon,  8 Sep 2025 10:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DZaET39O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F72A2F879
	for <linux-acpi@vger.kernel.org>; Mon,  8 Sep 2025 10:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757328501; cv=none; b=uqb/8G+omG3qwlvAimkecAWIZzSSnQ3hzvaeLRpwNzNnE/wLluSCLNCGdyNPRkHmNUT45OQdjJPksPDv31cLV0pwwNticMlyMl/6fpwgeL6m9uT5UL68atC6QmWlL2G807lXiE6H3oF648M4YVIc65oFAULXpsFSllmGjREtmMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757328501; c=relaxed/simple;
	bh=aooWlxs61oe5XmAvG5mEG9jZb11jz6KzCxSNS1Hzn4k=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=OMDx0BlTPgXrY+f2CR0HPtJDnkApTYyrRg55Stfp7xXYgp3S7ysEP/k9yx6C3RE5ivsr3eQr9V2VOZDLbckk458aUqXivuA8EndqvKMnqFyCfVeBh0Kyv1I609HM7ksaPnLIx3rciIsP8iURpUOrfWijd1/fkPp8O2HtURN47Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DZaET39O; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45dcff2f313so25224575e9.0
        for <linux-acpi@vger.kernel.org>; Mon, 08 Sep 2025 03:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757328498; x=1757933298; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHs01z7oM1ANWId4X0P4WXVaPJBWZpLLCmKiOd/Ff+A=;
        b=DZaET39ON3QQRCLbqo3HcytUB1zoTavH3MAq41xiZRj4PWLwqk06hD2ecjQQpOneo5
         h4zIR1IcQBMhssnq7xl6gyLf40YwIOE3aa4uCMiI9Ge7ze+FAiVKkteHB9vOULiH0VFC
         fVBTHZAofKFfe3tLfzwyedNLE4MLjpvJI6yR5RS5j/MncaBAc08iCYxKYLANFj4UAm1e
         idVewv0Pw4gVJBYtojNrR1vpBBYfuPlvspE0i5/MXQwLzuMZMZmHDQkvm+z2Th5EDix8
         PpplO5WuVSDBcSdXILz7FW4tJjQ/l9rY0i+qXlg3fYZB6aSrkf1NuVB3n8UFpvoiT4bj
         0gjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757328498; x=1757933298;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vHs01z7oM1ANWId4X0P4WXVaPJBWZpLLCmKiOd/Ff+A=;
        b=fvWrozDvkoDFBinNICuDUUUaRKjTe1+H06CleDywFhmc//xiCJhTD79cKQBbH+ULxO
         r/cET7/J7L6GMcOJ2tYntnyyfHwnghi/pTk6bkJrR9Hwf6sQsjz/ig9ockVJCDOIkn0j
         0jUfrzyzSZ9sIL2Dnk4DNhJxFENExBXK9guBjxx/92i5Pizy93d9c4+osMesCeFLNUyy
         PUt9kwGqe0htxUXD9GTb2n3AlsrAnaen3ResV1NGP9hEnkZaQxEW5V6TlVlSVLPtbiXT
         fKcC8Ie9X86sc/6PkyMxf9M01SEREFLYAdYspCIAeXwsmbK3eOc/tAOtYEFyB03Y/z14
         yNpA==
X-Forwarded-Encrypted: i=1; AJvYcCX9NVWArkCt0kHiRiJWI988TzYfmlnJwkfgWEEHlMANIYBqoAM1yBxUdX3aYWwbFd86/2PBY8pl9VLy@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5HS9ZICB2qRSGn4wJFiWeGJCHRJ5YN+zorzw6KHh01yGPr+ER
	lKXpvtjk9LQDLFuQ7da9WgalzvWaIDL/r1h8HfUkhXvvkSDbqWgc36PuZegUcWIsKk4=
X-Gm-Gg: ASbGncuEEYwcIqW2WthCTzRD+jqUdauITkmq7FquhKQUapvQqqMWOJ1peARJn1/3A3M
	XSd/bX2SZGhvk8nTTPh40Mdh660oYV64Lhratkn+4pYLg2VfgqJI8D0XvkhhzhovVyf2p/WKTj6
	kWB0vJP4xkSk43eLg91HnvEG0yf+TjkGurEk90LaObGxaoh+qX9O9+nAxrNsXQMvfLs/oyrl8BW
	AxOmCS7EKK8W0LeoM1oLT6t+HL+PpxCNXIZQCewK5hR0UQXJ1AXiACHUnFS5ompEFoqsTBOYQ96
	zCSyiKmAgTMDoy3k4R6LfH/h6yO1iZw3iRdWldBXwiEp3vQJ6oFUmXO2uVn/KSFztYE1QxqqMK/
	sATkfa5+9jkfFXZea2vngxo6kuBz+S4Ow/WWuz5cJWc7KVcfCo9mA2FRihkWvmMBsKtzfd4DsXz
	azI7xqM3ve6IlU
X-Google-Smtp-Source: AGHT+IHPhOXQXGFj/kIOadcgTuaRxf22+4yFciHzJcYi4juLw9HJQxPZ/k92mxlesnF3xP6w9bAziw==
X-Received: by 2002:a05:600c:1d24:b0:456:fdd:6030 with SMTP id 5b1f17b1804b1-45dea83f76bmr8038565e9.19.1757328498296;
        Mon, 08 Sep 2025 03:48:18 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:9b6a:7b16:fb30:a294? ([2a05:6e02:1041:c10:9b6a:7b16:fb30:a294])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45dd6891d23sm140785655e9.4.2025.09.08.03.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 03:48:17 -0700 (PDT)
Message-ID: <2af92349-2c84-4f1c-b035-946c3996cd9f@linaro.org>
Date: Mon, 8 Sep 2025 12:48:16 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux PM mailing list <linux-pm@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Lukasz Luba <Lukasz.Luba@arm.com>, Saravana Kannan <saravanak@google.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Deepti Jaggi
 <quic_djaggi@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>,
 Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Srinivas Kandagatla <srini@kernel.org>, Amit Kucheria <amitk@kernel.org>,
 Abel Vesa <abel.vesa@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Steven Rostedt <rostedt@goodmis.org>
Subject: [CfP] LPC 2025: Power Management and Thermal Control Micro-Conference
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi everyone,

A Power Management and Thermal Control session will be held during this
year’s LPC, as has been the case for the past few years, and it is now
open for topic submissions.

The Power Management and Thermal Control microconference covers all
things related to saving energy and managing heat. Among other topics,
we care about thermal control infrastructure, CPU and device
power-management mechanisms, energy models, and power capping. In
particular, we are interested in improving and extending thermal control
support in the Linux kernel and in utilizing the energy-saving features
of modern hardware.

The overall goal is to facilitate cross-framework and cross-platform
discussions that help improve energy awareness and thermal control in
Linux.

This year some big topics have been identified, for more details, please 
refer to:

  https://lpc.events/event/19/contributions/2003/

If you have a topic connected to the big ones identified above or a new 
one to propose for this session, please go to:

  https://lpc.events/login/?next=/event/19/abstracts/%23submit-abstract

and select "Power Management and Thermal Control MC" in the Track field.

Please note that topics should not be about work that has already been 
completed, as is the case for LPC in general.

The deadline for submissions is October 15.

Thank you!


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


