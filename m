Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46DAEF6B9A
	for <lists+linux-acpi@lfdr.de>; Sun, 10 Nov 2019 22:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfKJV3h (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 10 Nov 2019 16:29:37 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:38618 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfKJV3h (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 10 Nov 2019 16:29:37 -0500
Received: by mail-wm1-f45.google.com with SMTP id z19so11275777wmk.3
        for <linux-acpi@vger.kernel.org>; Sun, 10 Nov 2019 13:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nV4R2l6cwPUGHq6goraRBWuQwlY13oxSS8W/vCdyUik=;
        b=KTHzmp32TuR8aam/YaVfGDTUuhVn0Xra8w64lvWEw7pm2kf5UE5n4vBPfV0MZ7ROPI
         EeZ+XIu7k6qZPKw0Doyep8Ho9eBLocbKuQuVpZuaAURxyi3r1pvfak3Yc7paywhfbpZ3
         ThQrNiD4iYvCVVJrxkdbFI3fg9F/EHoSs+9XEk1GVHj0PSyKyDDLEOD55LdfdU56FfPm
         QW5R0fxXsHHrsgcPL9wQrcj1zYi7zf6HaWzedZNWm+nr4Soe+YCyK3AZXPgMpsykzevJ
         nSFj1lTq+I1JaEx2gAwwiWaIGqRdL3voi0TSMCAxl8BSj+x4RlBF5ivZKLZ2NlT0TCLs
         G86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nV4R2l6cwPUGHq6goraRBWuQwlY13oxSS8W/vCdyUik=;
        b=JE8zxp3RrKZLdNv/M8cqA/GXHB8nNud73LX4AsdT85fQYpcV5LYevSNzzZXeu94GHD
         Aa4KWKFeZZDn7cGfWhwCLNEfCRbYpaeoS3BB9KPHD9L3/UPmUwRAmPZxW0H6tUnr8xxo
         qJZ612oSlxxGW5+bUCNPmHoyiMGCNB6fRJfIWP2AW/+o/yWG+2Dnm5PG0ods5f533XoB
         5yZYJp6RmelZyn6t6UXeFY5flrVmdtQKJMzKuMCRgrx1gSxUe83A8gWDRwa1CkBpNfjM
         rXG4J71UWBRnc0GCLssPUIpP4p9tQl42/xpZ92jm+6kU8hnjMwsDW0zPjL7YXZzcn9KV
         9tqA==
X-Gm-Message-State: APjAAAVAsZv+xADkcG7CgRu7n/59TmxF6iOTQwr67Z5LjYlklwxp+P6r
        iYIUTbr7EoWfNJ1tlX0TZSo=
X-Google-Smtp-Source: APXvYqxnYDzLXGxFskTlZ4a5FbYSbxLQFvbuPAsOp6lVryj8NQx5IZ90lPgEiQSwSoED74RV41y2fg==
X-Received: by 2002:a1c:3b82:: with SMTP id i124mr15166035wma.122.1573421374893;
        Sun, 10 Nov 2019 13:29:34 -0800 (PST)
Received: from [192.168.2.202] (pD9E5A712.dip0.t-ipconnect.de. [217.229.167.18])
        by smtp.gmail.com with ESMTPSA id v10sm26751301wmg.48.2019.11.10.13.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2019 13:29:34 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: PROBLEM: Calling ObjectType on buffer field reports type integer
To:     "Schmauss, Erik" <erik.schmauss@intel.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
References: <3ef42aa1-196d-f3db-0e5d-2fd84c198242@gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C592D47@ORSMSX122.amr.corp.intel.com>
 <CF6A88132359CE47947DB4C6E1709ED53C59405C@ORSMSX122.amr.corp.intel.com>
 <fe4bcc1c-5c15-caa6-ce01-a5df962ff008@gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C5942CA@ORSMSX122.amr.corp.intel.com>
 <51e156ec-c2ed-84be-13c0-99a213e1d4b7@gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C595C50@ORSMSX122.amr.corp.intel.com>
 <88077d9c-b2b7-5fc6-37e9-fa12d6aebe73@gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C614AA8@ORSMSX122.amr.corp.intel.com>
Message-ID: <c6511010-f160-a2ee-1b89-46df051a85e4@gmail.com>
Date:   Sun, 10 Nov 2019 22:29:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53C614AA8@ORSMSX122.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 7/23/19 1:01 AM, Schmauss, Erik wrote:
> Sorry about the late response. This slipped through the cracks.
> I've sent them an email just now and I'll keep you informed

Hi again,

is there any update on this?

Regards,

Maximilian
