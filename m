Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C02339B82
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Mar 2021 04:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbhCMDRH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Mar 2021 22:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhCMDQv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Mar 2021 22:16:51 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D975C061574;
        Fri, 12 Mar 2021 19:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ztltson60rrlbqyTdf4YRzaWyJJxJi/PgKBFk0gDvpk=; b=w8O+uZCJaIZZwLEBOiFEF+W9hF
        YMicVSCmu4ldqZJ34JItiX6hxSakwt22WebXWJqMeYI9Ld7leZxVJxKO8AWgnyYxlVGhb2MEEkxBQ
        qWFBQ2/QrLOSTc8QlWco+ygDyLOO8NkDu0Zd+NhbZJSFZw8OdLs3cfeKwGi0rJ2GPHoodaJAUBTA5
        4dq/V331uNupHCcFXppnQYyvZ0WiVqpdJ7U/W+8NR0gpD7N6rs7lKsFPN2l1f67jfG+eTh3qw4gDp
        TzUgRSoDPl5lmQDc1XkjJ+cyrUGvF7DX2A+hYfI9S6603vgWeFY00E2fnpJxlCCh/WJPOWOoAynzu
        m27aFFoA==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKulg-0017Et-K7; Sat, 13 Mar 2021 03:16:45 +0000
Subject: Re: [PATCH] ACPI: fix various typos in comments
To:     Tom Saeger <tom.saeger@oracle.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, trivial@kernel.org
References: <fa193b3c9e346ff3fc157b54802c29b25f79c402.1615597995.git.tom.saeger@oracle.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5320781b-6328-0dc0-3a2b-02955e688b18@infradead.org>
Date:   Fri, 12 Mar 2021 19:16:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <fa193b3c9e346ff3fc157b54802c29b25f79c402.1615597995.git.tom.saeger@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 3/12/21 5:55 PM, Tom Saeger wrote:
> Fix trivial ACPI driver comment typos.
> 
> s/notifcations/notifications/
> s/Ajust/Adjust/
> s/preform/perform/
> s/atrributes/attributes/
> s/Souce/Source/
> s/Evalutes/Evaluates/
> s/Evalutes/Evaluates/
> s/specifiy/specify/
> s/promixity/proximity/
> s/presuambly/presumably/
> s/Evalute/Evaluate/
> s/specificed/specified/
> s/rountine/routine/
> s/previosuly/previously/
> 
> Change comment referencing pcc_send_cmd to send_pcc_cmd.
> 
> Cc: trivial@kernel.org
> Signed-off-by: Tom Saeger <tom.saeger@oracle.com>
> ---
>  drivers/acpi/ac.c                     |  2 +-
>  drivers/acpi/acpi_video.c             |  4 ++--
>  drivers/acpi/apei/erst.c              |  2 +-
>  drivers/acpi/apei/hest.c              |  2 +-
>  drivers/acpi/cppc_acpi.c              | 10 +++++-----
>  drivers/acpi/numa/hmat.c              |  2 +-
>  drivers/acpi/pmic/intel_pmic_chtcrc.c |  2 +-
>  drivers/acpi/power.c                  |  2 +-
>  drivers/acpi/processor_perflib.c      |  2 +-
>  drivers/acpi/resource.c               |  2 +-
>  drivers/acpi/scan.c                   |  2 +-
>  11 files changed, 16 insertions(+), 16 deletions(-)

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy

