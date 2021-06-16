Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A47F3A9DD6
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 16:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbhFPOn1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 10:43:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20088 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233941AbhFPOn1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Jun 2021 10:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623854480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jhGEfqLBwj9fV46fGK/pkIEcoOdHIa1uQlOokF9rz3E=;
        b=TQaqem6L2Udp775MZQxPTySSz96h16JWnHMBXyf1IXrzvfcW9D48SkjjszZDebjr9GtQ5c
        mo3g6tzfRmIL1mktRF7bVGL7YeGO3JLBIFolA16ZTYCDgXLtTjuNvdUKz7i5SAEQJetwiL
        fHZUbVJJ1OFYfaOTunuFCzKwTgRBIZQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-BbYVbieAOQ2dELMnC_6CRQ-1; Wed, 16 Jun 2021 10:41:19 -0400
X-MC-Unique: BbYVbieAOQ2dELMnC_6CRQ-1
Received: by mail-ed1-f70.google.com with SMTP id p24-20020aa7c8980000b0290393c37fdcb8so1169421eds.6
        for <linux-acpi@vger.kernel.org>; Wed, 16 Jun 2021 07:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jhGEfqLBwj9fV46fGK/pkIEcoOdHIa1uQlOokF9rz3E=;
        b=bTMIPKwcR1jxBCIwxPGFm3TKk5yEo1YyqkdbThZKDVCsIbQSEBypgL6q+TdyM7inYb
         3tjDL0z6inXRXR7gaq965MUhpPcygG96RHqg7fpKltimKJTs3dRBYj9dNB1tOQPSpwpE
         CcM5rGPb+ZRy6JDqcw8AYgfehv9NUVd48iY8FOH1PpdZ7fpDBGs+xCn6TNhVfe96Ud9F
         4M/mjYu7Xq5gEi8T8p0M3FCgNq9YU5cAHUvkL1Z/dG2mx3el/g2atnCwyG6KxJskbh3p
         YI/hRoL8V2fgw85OG9AHVwduyZI3dcd9bDwhwcxj+GRnxAcz1oAN0Psp04WcZOqz0KTR
         Qa1w==
X-Gm-Message-State: AOAM533bMFIyXNQfuKHXdB+bLPwbYuRcgZ1bcAkFIOWvAuuU3Ggd1TIE
        dTSz8WKcD3BDI3SO1+Yckp52XMZt09JC+2krqmlrmee9iavKVPADRxnX9GowQeqPt5MKXwB+w76
        WPHQlmSjD8ISx3SSfL9tSK/+K+s9SOLJz5nCc3F4cuVrV4rDtcw4YO0dX+EC7KbY4lLJHKdzsxg
        ==
X-Received: by 2002:a05:6402:2742:: with SMTP id z2mr4747202edd.66.1623854478007;
        Wed, 16 Jun 2021 07:41:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxT4PeQpWXh2w9CpJXZTY1ozkVrQW0WD9LazunyxsYuvbw6xA7oM5geMuuWlLreNjxGIR9LRw==
X-Received: by 2002:a05:6402:2742:: with SMTP id z2mr4747173edd.66.1623854477833;
        Wed, 16 Jun 2021 07:41:17 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id f15sm1772845ejl.60.2021.06.16.07.41.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 07:41:17 -0700 (PDT)
Subject: Re: [GIT PULL] acpi-scan material for v5.14
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <CAJZ5v0h+HG5eDcjBJKxNqnEbOKayG8A2wk337NmRio_OxurGEA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7297aa37-5800-fb11-b7a1-2d760c0b19df@redhat.com>
Date:   Wed, 16 Jun 2021 16:41:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0h+HG5eDcjBJKxNqnEbOKayG8A2wk337NmRio_OxurGEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On 6/11/21 6:28 PM, Rafael J. Wysocki wrote:
> Hi Hans,
> 
> The following commits:
> 
> 23db673d7e51 ACPI: scan: initialize local variable to avoid garbage
> being returned
> b83e2b306736 ACPI: scan: Add function to fetch dependent of ACPI device
> a9e10e587304 ACPI: scan: Extend acpi_walk_dep_device_list()
> 6d27975851b1 ACPI: scan: Rearrange dep_unmet initialization
> 
> are available for you to pull from from the git branch at:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  acpi-scan
> 
> that is not going to be rebased before merging.

Thank you, I've merged this into the review-hans branch of
platform-drivers-x86 now, because this is a dependency for:
https://patchwork.kernel.org/project/platform-driver-x86/patch/20210603224007.120560-6-djrscally@gmail.com/

After I've run some tests I will push the review-hans branch
to the for-next branch.

Regards,

Hans


