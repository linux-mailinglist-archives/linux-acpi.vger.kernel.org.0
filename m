Return-Path: <linux-acpi+bounces-9239-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1B69B9452
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2024 16:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31DAC1C21A2D
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2024 15:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F9F1C3F32;
	Fri,  1 Nov 2024 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NTVAs67Y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB79C7482;
	Fri,  1 Nov 2024 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730474546; cv=none; b=Y6ouS656wcrz6Q9vORbLBsbbHn5pJTRcesXdeQhr1XGfIHgRybT8SW/VfrXGNyGIeMaO/wkG330RhdLXlKAz+KizbMJRpLdhwSrUj3M/0z+AcPrdu1U2xIV1qTkqXYEU7PdYaioqT5C6DPRkkgByJiaX/kD9zsHxTckNejskLOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730474546; c=relaxed/simple;
	bh=cVmHLaPGigvflDEqAOfwrZjRkmGQh8/WUjNZ4uZ48Co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1fYDmdiKUe7R4Y3d3fIBlEz8qSm//kYktkBizFT1P8YMDLWGlA/NBQMMl5q0VATj5X5iEFTZbWBHIcfzNMTuQl0vBsr8WPW791wq1YPqLhPaACJdQLgZOrYt8ejbO5QwK7uRLL0CwmY8sUamJI7Imz4PWAEo2UeRSxXx0WQAX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NTVAs67Y; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730474545; x=1762010545;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cVmHLaPGigvflDEqAOfwrZjRkmGQh8/WUjNZ4uZ48Co=;
  b=NTVAs67YHrH0up6Er5FQ6tJcp1YcoYmkRQXuASjlCafDka3RZoRBVM8t
   5G/Guxr13Rq8XSCMMYkr8NJ1/0zK3dWw02aWjgHCPD0XgwEXqCtKND7LU
   xnf5EMdzuoWo3EYs6nI0I0bDQ4r5JYL8+RhB0OmhOhZLR1iKQRvbOXaBa
   +0qLKj4iurGkBKMdIOd5+i2ksa6/53reJEWEgBWFP9R3m8hWNKzCid5+X
   BBojgzUaZZyhhR8ya83EU4iHf5Ocgosbw6D+N7OYweV4xJZatuyLlk7rl
   ktN0wTfwj4kLtKqNwWQI7ujXnKtGjJLtL1/tHHKMzVQuNyOf/3rcFnfMx
   w==;
X-CSE-ConnectionGUID: 6C+0ZS4+TR2D95iUXxZimA==
X-CSE-MsgGUID: vZXYeFOqTMapt2VgiPQc0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="47732930"
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="47732930"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 08:22:23 -0700
X-CSE-ConnectionGUID: VRzW+vvZQTCPenCgxv9uPg==
X-CSE-MsgGUID: t/J48C2RS7m2W5ADNvk96A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="83330929"
Received: from ccbilbre-mobl3.amr.corp.intel.com (HELO [10.124.220.146]) ([10.124.220.146])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 08:22:21 -0700
Message-ID: <44325592-4185-4d14-8e8c-6b5b27bb4908@intel.com>
Date: Fri, 1 Nov 2024 08:22:20 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] x86: probe memory block size advisement value
 during mm init
To: Gregory Price <gourry@gourry.net>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org, Jonathan.Cameron@huawei.com,
 dan.j.williams@intel.com, rrichter@amd.com, Terry.Bowman@amd.com,
 dave.jiang@intel.com, ira.weiny@intel.com, alison.schofield@intel.com,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 rafael@kernel.org, lenb@kernel.org, david@redhat.com, osalvador@suse.de,
 gregkh@linuxfoundation.org, akpm@linux-foundation.org, rppt@kernel.org
References: <20241101134706.1185-1-gourry@gourry.net>
 <20241101134706.1185-3-gourry@gourry.net>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 xsFNBE6HMP0BEADIMA3XYkQfF3dwHlj58Yjsc4E5y5G67cfbt8dvaUq2fx1lR0K9h1bOI6fC
 oAiUXvGAOxPDsB/P6UEOISPpLl5IuYsSwAeZGkdQ5g6m1xq7AlDJQZddhr/1DC/nMVa/2BoY
 2UnKuZuSBu7lgOE193+7Uks3416N2hTkyKUSNkduyoZ9F5twiBhxPJwPtn/wnch6n5RsoXsb
 ygOEDxLEsSk/7eyFycjE+btUtAWZtx+HseyaGfqkZK0Z9bT1lsaHecmB203xShwCPT49Blxz
 VOab8668QpaEOdLGhtvrVYVK7x4skyT3nGWcgDCl5/Vp3TWA4K+IofwvXzX2ON/Mj7aQwf5W
 iC+3nWC7q0uxKwwsddJ0Nu+dpA/UORQWa1NiAftEoSpk5+nUUi0WE+5DRm0H+TXKBWMGNCFn
 c6+EKg5zQaa8KqymHcOrSXNPmzJuXvDQ8uj2J8XuzCZfK4uy1+YdIr0yyEMI7mdh4KX50LO1
 pmowEqDh7dLShTOif/7UtQYrzYq9cPnjU2ZW4qd5Qz2joSGTG9eCXLz5PRe5SqHxv6ljk8mb
 ApNuY7bOXO/A7T2j5RwXIlcmssqIjBcxsRRoIbpCwWWGjkYjzYCjgsNFL6rt4OL11OUF37wL
 QcTl7fbCGv53KfKPdYD5hcbguLKi/aCccJK18ZwNjFhqr4MliQARAQABzUVEYXZpZCBDaHJp
 c3RvcGhlciBIYW5zZW4gKEludGVsIFdvcmsgQWRkcmVzcykgPGRhdmUuaGFuc2VuQGludGVs
 LmNvbT7CwXgEEwECACIFAlQ+9J0CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEGg1
 lTBwyZKwLZUP/0dnbhDc229u2u6WtK1s1cSd9WsflGXGagkR6liJ4um3XCfYWDHvIdkHYC1t
 MNcVHFBwmQkawxsYvgO8kXT3SaFZe4ISfB4K4CL2qp4JO+nJdlFUbZI7cz/Td9z8nHjMcWYF
 IQuTsWOLs/LBMTs+ANumibtw6UkiGVD3dfHJAOPNApjVr+M0P/lVmTeP8w0uVcd2syiaU5jB
 aht9CYATn+ytFGWZnBEEQFnqcibIaOrmoBLu2b3fKJEd8Jp7NHDSIdrvrMjYynmc6sZKUqH2
 I1qOevaa8jUg7wlLJAWGfIqnu85kkqrVOkbNbk4TPub7VOqA6qG5GCNEIv6ZY7HLYd/vAkVY
 E8Plzq/NwLAuOWxvGrOl7OPuwVeR4hBDfcrNb990MFPpjGgACzAZyjdmYoMu8j3/MAEW4P0z
 F5+EYJAOZ+z212y1pchNNauehORXgjrNKsZwxwKpPY9qb84E3O9KYpwfATsqOoQ6tTgr+1BR
 CCwP712H+E9U5HJ0iibN/CDZFVPL1bRerHziuwuQuvE0qWg0+0SChFe9oq0KAwEkVs6ZDMB2
 P16MieEEQ6StQRlvy2YBv80L1TMl3T90Bo1UUn6ARXEpcbFE0/aORH/jEXcRteb+vuik5UGY
 5TsyLYdPur3TXm7XDBdmmyQVJjnJKYK9AQxj95KlXLVO38lczsFNBFRjzmoBEACyAxbvUEhd
 GDGNg0JhDdezyTdN8C9BFsdxyTLnSH31NRiyp1QtuxvcqGZjb2trDVuCbIzRrgMZLVgo3upr
 MIOx1CXEgmn23Zhh0EpdVHM8IKx9Z7V0r+rrpRWFE8/wQZngKYVi49PGoZj50ZEifEJ5qn/H
 Nsp2+Y+bTUjDdgWMATg9DiFMyv8fvoqgNsNyrrZTnSgoLzdxr89FGHZCoSoAK8gfgFHuO54B
 lI8QOfPDG9WDPJ66HCodjTlBEr/Cwq6GruxS5i2Y33YVqxvFvDa1tUtl+iJ2SWKS9kCai2DR
 3BwVONJEYSDQaven/EHMlY1q8Vln3lGPsS11vSUK3QcNJjmrgYxH5KsVsf6PNRj9mp8Z1kIG
 qjRx08+nnyStWC0gZH6NrYyS9rpqH3j+hA2WcI7De51L4Rv9pFwzp161mvtc6eC/GxaiUGuH
 BNAVP0PY0fqvIC68p3rLIAW3f97uv4ce2RSQ7LbsPsimOeCo/5vgS6YQsj83E+AipPr09Caj
 0hloj+hFoqiticNpmsxdWKoOsV0PftcQvBCCYuhKbZV9s5hjt9qn8CE86A5g5KqDf83Fxqm/
 vXKgHNFHE5zgXGZnrmaf6resQzbvJHO0Fb0CcIohzrpPaL3YepcLDoCCgElGMGQjdCcSQ+Ci
 FCRl0Bvyj1YZUql+ZkptgGjikQARAQABwsFfBBgBAgAJBQJUY85qAhsMAAoJEGg1lTBwyZKw
 l4IQAIKHs/9po4spZDFyfDjunimEhVHqlUt7ggR1Hsl/tkvTSze8pI1P6dGp2XW6AnH1iayn
 yRcoyT0ZJ+Zmm4xAH1zqKjWplzqdb/dO28qk0bPso8+1oPO8oDhLm1+tY+cOvufXkBTm+whm
 +AyNTjaCRt6aSMnA/QHVGSJ8grrTJCoACVNhnXg/R0g90g8iV8Q+IBZyDkG0tBThaDdw1B2l
 asInUTeb9EiVfL/Zjdg5VWiF9LL7iS+9hTeVdR09vThQ/DhVbCNxVk+DtyBHsjOKifrVsYep
 WpRGBIAu3bK8eXtyvrw1igWTNs2wazJ71+0z2jMzbclKAyRHKU9JdN6Hkkgr2nPb561yjcB8
 sIq1pFXKyO+nKy6SZYxOvHxCcjk2fkw6UmPU6/j/nQlj2lfOAgNVKuDLothIxzi8pndB8Jju
 KktE5HJqUUMXePkAYIxEQ0mMc8Po7tuXdejgPMwgP7x65xtfEqI0RuzbUioFltsp1jUaRwQZ
 MTsCeQDdjpgHsj+P2ZDeEKCbma4m6Ez/YWs4+zDm1X8uZDkZcfQlD9NldbKDJEXLIjYWo1PH
 hYepSffIWPyvBMBTW2W5FRjJ4vLRrJSUoEfJuPQ3vW9Y73foyo/qFoURHO48AinGPZ7PC7TF
 vUaNOTjKedrqHkaOcqB185ahG2had0xnFsDPlx5y
In-Reply-To: <20241101134706.1185-3-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/24 06:47, Gregory Price wrote:
> Systems with hotplug may provide an advisement value on what the
> memblock size should be.  Probe this value when the rest of the
> configuration values are considered.

It's too bad this doesn't simplify any of the arch code, but it's also
not making it much worse.  I assume this is something that will go
through the mm tree, so:

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>


