Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69586360BEE
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Apr 2021 16:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhDOOhD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Apr 2021 10:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbhDOOhC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Apr 2021 10:37:02 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EEBC061574
        for <linux-acpi@vger.kernel.org>; Thu, 15 Apr 2021 07:36:38 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id mh2so15660406ejb.8
        for <linux-acpi@vger.kernel.org>; Thu, 15 Apr 2021 07:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mjhKqmO4P/HOjUJ1FPn/2ppNQrINwg9izlySqB9JB+o=;
        b=dQZZhJUIg9fPycLxp1hIWYbqTlefJ9fS+5+3rx52g5lZ7R7l35A2B6Jk8Zv1ifQtl1
         FbvQhhMy++oWabaMTxmc3+n7aE2dKX/HhYmxsFwR3ACD/4oXzdGcRmTX7AtZDBI68+XL
         GiZiY7hJuSNwF1xthc6mUuIUt65fEc4YW9S+PFkFCB5OGH31pNIO8a8gPjxAp6ok3M0z
         lb02YlOr9jG1ltSD9X9/TY4ZKNuJnSotaJPn18OAEHFWufO9HQk5HOkecplCbRoUmwzo
         39EWdXnowOPmqd4LXuQEIzd2Sj5Cbr1g5DrpouiwNWVbTLHT/BTs5ZQnehxDa+TAtlCn
         VnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mjhKqmO4P/HOjUJ1FPn/2ppNQrINwg9izlySqB9JB+o=;
        b=NxPav4rWuM3890ZjjvwKdX7bss8MfTRQrGPN7HaaYwONEMrr7aMt5jqQvMGRBeUYmk
         mnuCJf7kVfW3TQd0psz/e3YjLcUt+pzx5T1DKJMU/RUadVGpQjfOwl+gEMLA0qINXM1+
         K3GHy9qQgiYDSVrr9eRTIlrwoRO3LSrbh1/1hAcyWMxT8wIJRSLSX2Kj7pSIRawDHSBp
         pBVKyqrGCP5An4+DqhPPT5+uYZ3RYxa/B9vgDArJG3j+2XM/6ZBJ/suHmpyA20s6Q/KJ
         2+3M9gXqLQfFyypCfsw7nJJe6O7sehA+619Wn4KdxXHudcmp9/C/reL13edCDGYEKAJO
         0hEg==
X-Gm-Message-State: AOAM532amBRIKi0LWmxkWw7e6IJnWr7QJf8l+YpGF0WT0lXgM80xAHof
        qZlQBkALhJi+21c4ObKEuiksHg==
X-Google-Smtp-Source: ABdhPJxT42RtxEVSUyx6KmXpl8AEmphR/mLq1GM6Y9HSFmPvxfBq2sTK8w7eGMSiQrfyfZIiwQtvKQ==
X-Received: by 2002:a17:907:20f2:: with SMTP id rh18mr3764125ejb.466.1618497397471;
        Thu, 15 Apr 2021 07:36:37 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id g20sm2776358edu.91.2021.04.15.07.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 07:36:37 -0700 (PDT)
Date:   Thu, 15 Apr 2021 16:36:17 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org,
        mst@redhat.com, will@kernel.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        sebastien.boeuf@intel.com, robin.murphy@arm.com,
        kevin.tian@intel.com, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH 1/3] ACPICA: iASL: Add definitions for the VIOT table
Message-ID: <YHhPYYXx/gTsx52x@myrica>
References: <20210316191652.3401335-1-jean-philippe@linaro.org>
 <20210316191652.3401335-2-jean-philippe@linaro.org>
 <83d8f573-0a96-5869-2c22-249bf2db7399@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83d8f573-0a96-5869-2c22-249bf2db7399@redhat.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 18, 2021 at 06:52:44PM +0100, Auger Eric wrote:
> Besides
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks, though this patch comes from ACPICA and has now been merged with
the other ACPICA updates:
https://lore.kernel.org/linux-acpi/20210406213028.718796-1-erik.kaneda@intel.com/

Thanks,
Jean
