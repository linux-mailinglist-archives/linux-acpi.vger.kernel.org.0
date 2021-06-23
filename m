Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426763B1EB1
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Jun 2021 18:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbhFWQbT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Jun 2021 12:31:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229902AbhFWQbP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 23 Jun 2021 12:31:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E93E61350;
        Wed, 23 Jun 2021 16:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624465738;
        bh=r4YKzhDT6S2mPQ+5hEgonlfzwke4UWS0t2mdsGa79Z0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hvrz4kEnLMO5yMkyHPwHybg5xWpfz1pNbjnMT3nYTYJuCNlhrzhaUfK/sNNTvmV1O
         ascsKkgcZhX461cs95MeHbs9XBCxtSoQ+Vx5kyDEBz9XSRDkkj7cMQpZv8n+Qid6FP
         KZdz4tZ37QYvRchwIzVv+wRWWT8+0HLCUw7pBrpgjDepr37zeBqGj7l9YvodukiOuc
         2npyZ+Mw3JwJOLwx27Xy4NaXdVuYQUPjqgTYadQVwVauQZokCKM+VYzH7k38hnJAfS
         j6owaysPKExWNvvTDKE7QaJyOoWcaknHR0knJU+B/NWtJAghMzGCWLSMnpc0xwRGZZ
         qOsut+EyUBRjg==
Subject: Re: [PATCH 2/2] ACPI: bgrt: Use sysfs_emit
To:     Kees Cook <keescook@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        clang-built-linux@googlegroups.com
References: <20210623013802.1904951-1-nathan@kernel.org>
 <20210623013802.1904951-2-nathan@kernel.org>
 <202106222250.7BD80A12FF@keescook>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <a155e3ee-69aa-408d-208b-06144cf6cf8f@kernel.org>
Date:   Wed, 23 Jun 2021 09:28:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202106222250.7BD80A12FF@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 6/22/2021 10:51 PM, Kees Cook wrote:
> On Tue, Jun 22, 2021 at 06:38:02PM -0700, Nathan Chancellor wrote:
>> sysfs_emit is preferred to snprintf for emitting values after
>> commit 2efc459d06f1 ("sysfs: Add sysfs_emit and sysfs_emit_at to format
>> sysfs output").
>>
>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> 
> Perhaps just squash this into patch 1? Looks good otherwise!
> 

I thought about it but sysfs_emit is a relatively new API and the 
previous change may want to be backported but I do not have a strong 
opinion so I can squash it if Rafael or Len feel strongly :)

Thanks for taking a look, cheers!
Nathan
