Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F312C4E91
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Nov 2020 07:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387889AbgKZGGB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 Nov 2020 01:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732387AbgKZGGB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Nov 2020 01:06:01 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC27C0617A7
        for <linux-acpi@vger.kernel.org>; Wed, 25 Nov 2020 22:06:00 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id j23so710401iog.6
        for <linux-acpi@vger.kernel.org>; Wed, 25 Nov 2020 22:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jonmasters-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oEy5q2En1SJI6u34J14mPbz3ymhjWNLu2ImEmUAs9Ws=;
        b=fODQbTzlog4xbJsMW2izr9T6xV3uC+lc03b1qJ1qSawbRoENnx1Br2TPMmRNY6FXY4
         ozf90S+p14K47ND2crcJTtExuHJ8j6Mt8bza5gS/hxyN2GTaVHahBV6A1qInS4vXwlaJ
         81eY/junYJYx/Vcf856DH3Cr64N7ZU+cwY5VtTc+zMWwF6Gq0mZDmDOe50yNYYTWh6Ip
         jHM+22whCE31Y3BcnmQ8X24tSHUX3wrQjR60Ftzfhqz2HvEr8bG0XTZ0osF0LAr2RnDj
         MFu4B+QaX/B6Kv1Jqj7k+MhrL15GlxJq+d6WmVs45l8wsfvnf4REBe3jxfZKDGcMFhR8
         +1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=oEy5q2En1SJI6u34J14mPbz3ymhjWNLu2ImEmUAs9Ws=;
        b=cQzFlLcngXrbWTZP7YZHQBRQf3ODY1vlq4OCQJRKtepbljrrvktAzQ6QNN7wV94CWw
         CvP7xIfAym7XiOqeiXMYU/XNR2OLFCUVUgagkCYxtWfoENVpEgV/YeIY+ySzZ//JT3R1
         rf/8OW2PVmmKOyuwcjqseFFRUgBuq5awhP85Rdf8vxjgSIWmfUHtjqA4epf5f1VdkR7b
         W3zVEy++XyrXcZiM/vpMcA7SMOpd0MrEk7085QvQLgRUMHEBX8MIkZfawizPfLRnnRYX
         9T5AXkAXD1hma/GIZzLDU2YrNt/7SmGFPZ4RN6pMuvTTX0kcNalSkJU9GzwxzNZ7ETnK
         q2CQ==
X-Gm-Message-State: AOAM531xnDMHjdr4WHt9agxKlHDyywbBVi6tj9RHiROlQradw7XjZIBQ
        vaat4dxuB2c6CZMRUMz0TonyOQ==
X-Google-Smtp-Source: ABdhPJwFDDEDdU/s/zYaPx0ggHOsOr62MbBrECZawSaq4PlqyTZscFc4nlCfmRS2OLqWEFdp3N4DEA==
X-Received: by 2002:a02:4c8:: with SMTP id 191mr1865300jab.70.1606370760006;
        Wed, 25 Nov 2020 22:06:00 -0800 (PST)
Received: from independence.bos.jonmasters.org (Boston.jonmasters.org. [50.195.43.97])
        by smtp.gmail.com with ESMTPSA id e18sm2531397ilc.52.2020.11.25.22.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2020 22:05:59 -0800 (PST)
Subject: Re: [RFC PATCH 5/9] cxl/mem: Find device capabilities
To:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20201111054356.793390-1-ben.widawsky@intel.com>
 <20201111054356.793390-6-ben.widawsky@intel.com>
From:   Jon Masters <jcm@jonmasters.org>
Organization: World Organi{s,z}ation of Broken Dreams
Message-ID: <8d332852-9c54-95e0-58c7-72939f347aa6@jonmasters.org>
Date:   Thu, 26 Nov 2020 01:05:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20201111054356.793390-6-ben.widawsky@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 11/11/20 12:43 AM, Ben Widawsky wrote:

> +		case CXL_CAPABILITIES_CAP_ID_SECONDARY_MAILBOX:
> +			dev_dbg(&cxlm->pdev->dev,
> +				   "found UNSUPPORTED Secondary Mailbox capability\n");

Per spec, the secondary mailbox is intended for use by platform 
firmware, so Linux should never be using it anyway. Maybe that message 
is slightly misleading?

Jon.

P.S. Related - I've severe doubts about the mailbox approach being 
proposed by CXL and have begun to push back through the spec org.

-- 
Computer Architect
