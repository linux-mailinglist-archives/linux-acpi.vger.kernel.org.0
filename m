Return-Path: <linux-acpi+bounces-167-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E80737AF64E
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 00:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A165F2810F8
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 22:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8AE3AC16
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 22:31:12 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55518347AA
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 21:30:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F5FC07618;
	Tue, 26 Sep 2023 21:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695763840;
	bh=4GMeUJSKKReF6s3SEqksGnEq5C7PEvuoRGdNtW/1FtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pUNQ7l0J63nPh9zcScWHpNRd7CxN1iVpP5n3+8OHy+P/13ioWXGZHGSDOWx9TIBEc
	 cUcEy9LpdMXEGN7+cZ4NaIRl4bJQ6Pwxa08G6O9cU/9vkDscjQrXvpHeYaPowK3nMM
	 j5zjUxRYn6Mcf6Fk9+GvczcYC+kX9sLms7sObqU2LUPFAZYnhlPGpJ9O0pw5ZN3BtD
	 YGn+G/01R5WCVJ41DEjiDhrK5O5df2XO+6qbJb8sxqGk9U/3SOan0p3z4/85dKc8HO
	 pGI0ujyB7LKjR412OyN/v8DWyf8nWfpnsxq9ISvFNFi8fzpaENexQN3h7RC5DI6Q0/
	 dko1p/x23ucPA==
Date: Tue, 26 Sep 2023 23:30:35 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/3] i2c: xgene-slimpro: Migrate to use generic PCC shmem
 related macros
Message-ID: <20230926213035.5dwlepgocda7xgd2@zenone.zhora.eu>
References: <20230926-pcc_defines-v1-0-0f925a1658fd@arm.com>
 <20230926-pcc_defines-v1-2-0f925a1658fd@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926-pcc_defines-v1-2-0f925a1658fd@arm.com>

Hi Sudeep,

> Use the newly defined common and generic PCC shared memory region
> related macros in this driver to replace the locally defined ones.
> 
> Cc: Andi Shyti <andi.shyti@kernel.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org> 

Thanks,
Andi

