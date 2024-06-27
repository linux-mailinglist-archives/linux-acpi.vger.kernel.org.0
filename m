Return-Path: <linux-acpi+bounces-6651-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE0A91A66D
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jun 2024 14:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C851F26875
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jun 2024 12:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5129154C00;
	Thu, 27 Jun 2024 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y/NRSoW6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB7C153BF6
	for <linux-acpi@vger.kernel.org>; Thu, 27 Jun 2024 12:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719490747; cv=none; b=PpjCuhYkHIu3srObv4EmcukI+rVFm0lyMRn95tqpNSLxdbg6QSoX5YPHnkng8sFYZuHiOkgeCeJE4CLtV5kOKxREehouv5hu2LBXcWGQLqbJAFylQpppaftunIVP/THW0CFvLMVqY79NBKuY2Cb+/Vp2tVXL/t+pL+pYqhqmd5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719490747; c=relaxed/simple;
	bh=3O+KMfa5juYo//dxio6Ns3wwUTqB7ExogyLVf2mXxKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaH2qnmUUGAfkvQsF7Fc76/yMGvBVG2lICy2McVsDFyGLCLb80M0cX7SGo2T1i7qeRrUSkXFcBfxUjvhnhGTITrF0qEhMvi3woyuR/0oIq46w82yyBIzmvvaWl1g7T8hglWYJVpWbiIE8JwzyuWUre4hgXGnDJpiKFZ8XGXXbzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y/NRSoW6; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719490747; x=1751026747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3O+KMfa5juYo//dxio6Ns3wwUTqB7ExogyLVf2mXxKk=;
  b=Y/NRSoW6GPR7+EoXx+cXMXQ8u1i3a1xCJSJd5AY404ScfE4uLuzThfUL
   +UDyLolJuhOXlng2CCPd4iFDx7IUXtFhoLpjbrh/8RlHTV3ueol2bFiBk
   eDS9moBd9Hp9mwJSp421lGICScPeL9fkgfM0AJbl7bHAz8kp8CRzd1Any
   +BTU5Yx3KT8J1rGyxoaK/awJcwydKelMyQ/83GiXq4Qk+JcNHc7b4OQ0I
   6DSQbwAP9F+m4xcOJq6JYsoEhdrFofPVwfAO9drObFwp8rWS4CXxpvOZA
   CJXU8Y0kFQHYYp+FcYUBWGMNxs63lQvDBwp3jJQYdQ3qRFkRVI5uJYxZT
   g==;
X-CSE-ConnectionGUID: INdx6AcaQGSZf2FNLn+pXA==
X-CSE-MsgGUID: auBn2Ke3QD6W5ShT1pIrwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16433256"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="16433256"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 05:19:05 -0700
X-CSE-ConnectionGUID: /WeOo52gRZePLaeqo9POUw==
X-CSE-MsgGUID: fAUGf9HeT5+PrzzA8cMxBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="44423710"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 27 Jun 2024 05:19:03 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMo5c-000GBK-2f;
	Thu, 27 Jun 2024 12:19:00 +0000
Date: Thu, 27 Jun 2024 20:18:35 +0800
From: kernel test robot <lkp@intel.com>
To: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>,
	linux-acpi@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
Subject: Re: [PATCH v2 2/2] ACPI: PM: Use max() for clearer D3 state
 selection in acpi_dev_pm_get_state
Message-ID: <202406271915.8djHC3jQ-lkp@intel.com>
References: <20240626130941.1527127-3-prabhakar.pujeri@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240626130941.1527127-3-prabhakar.pujeri@gmail.com>

Hi Prabhakar,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v6.10-rc5 ne=
xt-20240626]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Prabhakar-Pujeri/ACP=
I-CPPC-Replace-ternary-operator-with-max-in-cppc_find_dmi_mhz/20240627-0329=
38
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
 linux-next
patch link:    https://lore.kernel.org/r/20240626130941.1527127-3-prabhakar=
=2Epujeri%40gmail.com
patch subject: [PATCH v2 2/2] ACPI: PM: Use max() for clearer D3 state sele=
ction in acpi_dev_pm_get_state
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240=
627/202406271915.8djHC3jQ-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15=
a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive=
/20240627/202406271915.8djHC3jQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406271915.8djHC3jQ-lkp@i=
ntel.com/

All errors (new ones prefixed by >>):

>> drivers/acpi/device_pm.c:763:12: error: static assertion failed due to r=
equirement '__builtin_choose_expr((sizeof(int) =3D=3D sizeof (*(8 ? ((void =
*)((long)((((unsigned long long)(-1)) < (unsigned long long)1)) * 0L)) : (i=
nt *)8))), (((unsigned long long)(-1)) < (unsigned long long)1), 0) =3D=3D =
__builtin_choose_expr((sizeof(int) =3D=3D sizeof (*(8 ? ((void *)((long)(((=
(int)(-1)) < (int)1)) * 0L)) : (int *)8))), (((int)(-1)) < (int)1), 0) || _=
_builtin_choose_expr((sizeof(int) =3D=3D sizeof (*(8 ? ((void *)((long)((((=
unsigned long long)(-1)) < (unsigned long long)1)) * 0L)) : (int *)8))), ((=
(unsigned long long)(-1)) < (unsigned long long)1), 0) =3D=3D __builtin_cho=
ose_expr((sizeof(int) =3D=3D sizeof (*(8 ? ((void *)((long)((((int)(-1)) < =
(int)1)) * 0L)) : (int *)8))), (((int)(-1)) < (int)1), 0) || (__builtin_cho=
ose_expr((sizeof(int) =3D=3D sizeof (*(8 ? ((void *)((long)(ret) * 0L)) : (=
int *)8))) && __builtin_choose_expr((sizeof(int) =3D=3D sizeof (*(8 ? ((voi=
d *)((long)((((unsigned long long)(-1)) < (unsigned long long)1)) * 0L)) : =
(int *)8))), (((unsigned long long)(-1)) < (unsigned long long)1), 0), ret,=
 -1) >=3D 0) || (__builtin_choose_expr((sizeof(int) =3D=3D sizeof (*(8 ? ((=
void *)((long)(d_min) * 0L)) : (int *)8))) && __builtin_choose_expr((sizeof=
(int) =3D=3D sizeof (*(8 ? ((void *)((long)((((int)(-1)) < (int)1)) * 0L)) =
: (int *)8))), (((int)(-1)) < (int)1), 0), d_min, -1) >=3D 0)': max(ret, d_=
min) signedness error, fix types or consider umax() before max_t()
     763 |                         d_max =3D max(ret, d_min);
         |                                 ^~~~~~~~~~~~~~~
   include/linux/minmax.h:92:19: note: expanded from macro 'max'
      92 | #define max(x, y)       __careful_cmp(max, x, y)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:58:3: note: expanded from macro '__careful_cmp'
      58 |                 __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_=
ID(__y)))
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
   include/linux/minmax.h:51:16: note: expanded from macro '__cmp_once'
      51 |         static_assert(__types_ok(x, y),                 \
         |         ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      52 |                 #op "(" #x ", " #y ") signedness error, fix type=
s or consider u" #op "() before " #op "_t()"); \
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=
=3D0 to see all)
   include/linux/minmax.h:31:2: note: expanded from macro '__is_signed'
      31 |         __builtin_choose_expr(__is_constexpr(is_signed_type(type=
of(x))),        \
         |         ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_asser=
t'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_AR=
GS__, #expr)
         |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~=
~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_ass=
ert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   1 error generated.


vim +763 drivers/acpi/device_pm.c

   646=09
   647	/**
   648	 * acpi_dev_pm_get_state - Get preferred power state of ACPI device.
   649	 * @dev: Device whose preferred target power state to return.
   650	 * @adev: ACPI device node corresponding to @dev.
   651	 * @target_state: System state to match the resultant device state.
   652	 * @d_min_p: Location to store the highest power state available to =
the device.
   653	 * @d_max_p: Location to store the lowest power state available to t=
he device.
   654	 *
   655	 * Find the lowest power (highest number) and highest power (lowest =
number) ACPI
   656	 * device power states that the device can be in while the system is=
 in the
   657	 * state represented by @target_state.  Store the integer numbers re=
presenting
   658	 * those stats in the memory locations pointed to by @d_max_p and @d=
_min_p,
   659	 * respectively.
   660	 *
   661	 * Callers must ensure that @dev and @adev are valid pointers and th=
at @adev
   662	 * actually corresponds to @dev before using this function.
   663	 *
   664	 * Returns 0 on success or -ENODATA when one of the ACPI methods fai=
ls or
   665	 * returns a value that doesn't make sense.  The memory locations po=
inted to by
   666	 * @d_max_p and @d_min_p are only modified on success.
   667	 */
   668	static int acpi_dev_pm_get_state(struct device *dev, struct acpi_dev=
ice *adev,
   669					 u32 target_state, int *d_min_p, int *d_max_p)
   670	{
   671		char method[] =3D { '_', 'S', '0' + target_state, 'D', '\0' };
   672		acpi_handle handle =3D adev->handle;
   673		unsigned long long ret;
   674		int d_min, d_max;
   675		bool wakeup =3D false;
   676		bool has_sxd =3D false;
   677		acpi_status status;
   678=09
   679		/*
   680		 * If the system state is S0, the lowest power state the device can=
 be
   681		 * in is D3cold, unless the device has _S0W and is supposed to sign=
al
   682		 * wakeup, in which case the return value of _S0W has to be used as=
 the
   683		 * lowest power state available to the device.
   684		 */
   685		d_min =3D ACPI_STATE_D0;
   686		d_max =3D ACPI_STATE_D3_COLD;
   687=09
   688		/*
   689		 * If present, _SxD methods return the minimum D-state (highest pow=
er
   690		 * state) we can use for the corresponding S-states.  Otherwise, the
   691		 * minimum D-state is D0 (ACPI 3.x).
   692		 */
   693		if (target_state > ACPI_STATE_S0) {
   694			/*
   695			 * We rely on acpi_evaluate_integer() not clobbering the integer
   696			 * provided if AE_NOT_FOUND is returned.
   697			 */
   698			ret =3D d_min;
   699			status =3D acpi_evaluate_integer(handle, method, NULL, &ret);
   700			if ((ACPI_FAILURE(status) && status !=3D AE_NOT_FOUND)
   701			    || ret > ACPI_STATE_D3_COLD)
   702				return -ENODATA;
   703=09
   704			/*
   705			 * We need to handle legacy systems where D3hot and D3cold are
   706			 * the same and 3 is returned in both cases, so fall back to
   707			 * D3cold if D3hot is not a valid state.
   708			 */
   709			if (!adev->power.states[ret].flags.valid) {
   710				if (ret =3D=3D ACPI_STATE_D3_HOT)
   711					ret =3D ACPI_STATE_D3_COLD;
   712				else
   713					return -ENODATA;
   714			}
   715=09
   716			if (status =3D=3D AE_OK)
   717				has_sxd =3D true;
   718=09
   719			d_min =3D ret;
   720			wakeup =3D device_may_wakeup(dev) && adev->wakeup.flags.valid
   721				&& adev->wakeup.sleep_state >=3D target_state;
   722		} else if (device_may_wakeup(dev) && dev->power.wakeirq) {
   723			/*
   724			 * The ACPI subsystem doesn't manage the wake bit for IRQs
   725			 * defined with ExclusiveAndWake and SharedAndWake. Instead we
   726			 * expect them to be managed via the PM subsystem. Drivers
   727			 * should call dev_pm_set_wake_irq to register an IRQ as a wake
   728			 * source.
   729			 *
   730			 * If a device has a wake IRQ attached we need to check the
   731			 * _S0W method to get the correct wake D-state. Otherwise we
   732			 * end up putting the device into D3Cold which will more than
   733			 * likely disable wake functionality.
   734			 */
   735			wakeup =3D true;
   736		} else {
   737			/* ACPI GPE is specified in _PRW. */
   738			wakeup =3D adev->wakeup.flags.valid;
   739		}
   740=09
   741		/*
   742		 * If _PRW says we can wake up the system from the target sleep sta=
te,
   743		 * the D-state returned by _SxD is sufficient for that (we assume a
   744		 * wakeup-aware driver if wake is set).  Still, if _SxW exists
   745		 * (ACPI 3.x), it should return the maximum (lowest power) D-state =
that
   746		 * can wake the system.  _S0W may be valid, too.
   747		 */
   748		if (wakeup) {
   749			method[3] =3D 'W';
   750			status =3D acpi_evaluate_integer(handle, method, NULL, &ret);
   751			if (status =3D=3D AE_NOT_FOUND) {
   752				/* No _SxW. In this case, the ACPI spec says that we
   753				 * must not go into any power state deeper than the
   754				 * value returned from _SxD.
   755				 */
   756				if (has_sxd && target_state > ACPI_STATE_S0)
   757					d_max =3D d_min;
   758			} else if (ACPI_SUCCESS(status) && ret <=3D ACPI_STATE_D3_COLD) {
   759				/* Fall back to D3cold if ret is not a valid state. */
   760				if (!adev->power.states[ret].flags.valid)
   761					ret =3D ACPI_STATE_D3_COLD;
   762=09
 > 763				d_max =3D max(ret, d_min);
   764			} else {
   765				return -ENODATA;
   766			}
   767		}
   768=09
   769		if (d_min_p)
   770			*d_min_p =3D d_min;
   771=09
   772		if (d_max_p)
   773			*d_max_p =3D d_max;
   774=09
   775		return 0;
   776	}
   777=09

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

