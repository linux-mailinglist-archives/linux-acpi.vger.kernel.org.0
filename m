Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5837649C1F0
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jan 2022 04:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236981AbiAZDMF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Jan 2022 22:12:05 -0500
Received: from box.aukejan.com ([173.82.79.94]:57869 "EHLO box.aukejan.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237006AbiAZDMD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 25 Jan 2022 22:12:03 -0500
Received: from authenticated-user (box.aukejan.com [173.82.79.94])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.aukejan.com (Postfix) with ESMTPSA id B7CDD5D334;
        Tue, 25 Jan 2022 19:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=boldcoder.com;
        s=mail; t=1643166721;
        bh=TMADpJYl/gDJRX11bItQv/fTaLKFQL8tgY2+9vK83+I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RtJ0pE+bNsKJeskfUCGA44yPSTiS3/evyLzeYaGpBlAz/Sh8NKXzTfAZPfq9eB6ol
         XeoAKHtGb6MmhnOoEzot++RKA5CviO/l8X3H/Z3LcO1pMwdIjmh/xR7hmNfJ2QXTvi
         bXXs2NBtRiOP7jDOkPddhHRbMTvQbvYam4/3MmndkSHMb0mNYWU6ZwSuJQZ70pKgnL
         n1jfj1KUAj1xhPrXJlm8BpaF+OG683s185kgdg13M4fExRIpG3DSXHr4Gjo8HE7fYx
         Mbetny4x+F8ddIEA5YtgzyPHsd/Sli4JCqchTJu1qLcl3GB2NAiStCmudT4W9a0KSk
         Py7jQYMRaJThQ==
Subject: Re: Patch: Make ACPI subsystem provide CEDT table
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-cxl@vger.kernel.org, Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <1b871357-2231-336d-099c-cdccae03f837@boldcoder.com>
 <82f254a1-c765-0a87-f017-8c07c8ef07cd@boldcoder.com>
 <CAJZ5v0hRgzGm=axigeW9aPw+ai5hMCy975=vgdY4dGYZFzzMTA@mail.gmail.com>
From:   Robert Kiraly <me@boldcoder.com>
Message-ID: <46ce952d-e854-876d-26d4-b955064743f7@boldcoder.com>
Date:   Tue, 25 Jan 2022 19:12:02 -0800
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hRgzGm=axigeW9aPw+ai5hMCy975=vgdY4dGYZFzzMTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 01/25/2022 06:49AM, Rafael J. Wysocki wrote:
 >
 > ACPI_SIG_CEDT is defined in 5.17-rc1 AFAICS, so the #ifdef is redundant.

Noted. Thank you. Should I resubmit without the #ifdef or if the patch 
is accepted can it be removed by upstream?
